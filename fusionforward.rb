#!/usr/bin/ruby
  
require 'inifile'

class FusionForward
  def initialize(ini_path)
    @inifile = IniFile.load(ini_path)
  end

  def add(protocol, ipaddr, port)
    @inifile["incoming#{protocol}"][port] = "#{ipaddr}:#{port}"
  end

  def delete(protocol, port)
    @inifile["incoming#{protocol}"].delete(port)
  end

  def close 
    @inifile.write
  end
end
