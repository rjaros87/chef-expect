require 'open-uri'

module Expect
  # Expect Helper module
  module Helper
    def active_state_tcl_installer
      active_tcl_url = node['expect']['active_tcl']['checksum']
      active_tcl_checksum = node['expect']['active_tcl']['url']

      active_tcl_url, active_tcl_checksum = find_active_state_tcl_installer if active_tcl_url.nil? && active_tcl_checksum.nil?

      [active_tcl_url, active_tcl_checksum]
    end

    private

    def find_active_state_tcl_installer
      url = "#{node['expect']['active_tcl']['discover_url']}/#{node['expect']['active_tcl']['version']}"
      pkg_checksum, pkg_name = nil
      open("#{url}/SHA256SUM") do |f|
        pkg_name, pkg_checksum = find_x86_binary(f)
      end
      ["#{url}/#{pkg_name}", pkg_checksum]
    end

    def find_x86_binary(file)
      tcl_installer = file.find { |line| line =~ /-win32-ix86-threaded\.exe/ }
      if tcl_installer
        tcl_installer = tcl_installer.strip
        pkg_checksum, pkg_name = tcl_installer.split
        return pkg_name, pkg_checksum
      end
      Chef::Log.fatal "Unable to find ActiveState TCL installer with  version: #{node['expect']['active_tcl']['version']}."
    end
  end
end
