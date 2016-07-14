#
# Cookbook Name:: expect_script_test (for test purposes)
# Recipe:: script_win
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

cookbook_file 'Copy test.bat to $HOME' do
  backup false
  source 'test.bat'
  path "#{ENV['HOME']}/test.bat"
  action :create
end

expect_script 'Execute test.bat using expect script' do
  environment 'PATH' => "#{ENV['PATH']};#{node['expect']['cygwin']['home']}\\bin"
  code <<-EOH
    spawn cmd.exe /c #{ENV['HOME']}/test.bat "#{ENV['HOME']}"
    set timeout 30
    expect {
      -regexp "Would you like to delete your all files (yes/no)?.*" {
        exp_send "no\r"
        exp_continue
      }
      eof
    }
  EOH
end
