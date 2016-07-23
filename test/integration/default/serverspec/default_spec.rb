require 'spec_helper'

# Windows
describe file('C:\\cygwin'), if: os[:family] == 'windows' do
  it { should be_directory }
end

describe file('C:\\cygwin\\bin\\expect.exe'), if: os[:family] == 'windows' do
  it { should exist }
end

# Linux & Mac OS
describe package('expect'), if: os[:family] != 'windows' do
  it { should be_installed }
end

describe file("#{ENV['HOME']}/no.txt") do
  it { should exist }
end

describe file("#{ENV['HOME']}/yes.txt") do
  it { should_not exist }
end
