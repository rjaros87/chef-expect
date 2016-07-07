#
# Cookbook Name:: expect
# Recipe:: default
#
# Copyright 2016, Radoslaw Jaros
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'debian', 'rhel'
  package 'expect'
when 'mac_os_x'
  include_recipe 'homebrew' if node['expect']['include_homebrew']
  homebrew_tap 'homebrew/dupes'
  homebrew_package 'expect'
when 'windows'
  if node['expect']['active_tcl']['from_system']
    Chef::Log.info('Skipping the ActiveTcl installation because the attribute [\'expect\'][\'active_tcl\'][\'from_system\'] is set to true')
  else
    Chef::Recipe.send(:include, ::Windows::Helper)

    tcl_name = "ActiveState ActiveTcl #{node['expect']['active_tcl']['version']}"

    if is_package_installed?(tcl_name)
      Chef::Log.info("Package already installed: #{tcl_name}")
    else
      Chef::Recipe.send(:include, Expect::Helper)

      active_tcl_url, active_tcl_checksum = active_state_tcl_installer

      windows_package "#{tcl_name} Installer" do
        installer_type :custom
        options "--directory \"#{node['expect']['active_tcl']['directory']}\""
        checksum active_tcl_checksum
        source active_tcl_url
        action :install
      end
    end
    execute 'Install package Expect using teacup' do
      command 'teacup.exe install Expect'
      cwd "#{node['expect']['active_tcl']['directory']}/bin"
    end
  end
else
  Chef::Log.error "Platform '#{node['platform_family']}' not supported!"
end
