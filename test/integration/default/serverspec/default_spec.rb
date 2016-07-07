require 'spec_helper'

# Windows
describe package('ActiveState ActiveTcl 8.6.4.1'), if: os[:family] == 'windows' do
  it { should be_installed }
end

describe command('cd C:\Tcl\bin; teacup.exe list --at-default Expect'), if: os[:family] == 'windows' do
  its(:stdout) { should contain('package Expect') }
end

# Linux & Mac OS
describe package('expect'), if: os[:family] != 'windows' do
  it { should be_installed }
end
