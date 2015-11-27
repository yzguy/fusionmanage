#!/usr/bin/ruby

require 'rubygems'
require 'bundler/setup'

require 'inifile'
require 'colorize'

class FusionManage
  @@fusionbase = '/Applications/VMware\ Fusion.app/Contents/Library/vmnet-cli'
  @@stop = @@fusionbase + ' --stop'
  @@start = @@fusionbase + ' --start'
  @@natpath = "/Library/Preferences/VMware\ Fusion/vmnet8/nat.conf"

  def self.start_network
    system @@start
  end

  def self.stop_network
    system @@stop
  end

  def self.restart_network
    if system @@stop
      system @@start
    end
  end

  class FusionForward
    def initialize(ini_path)
      @inifile = IniFile.load(ini_path)
    end

    def close
      @inifile.write
    end

    def add(protocol, ipaddr, port)
      @inifile["incoming#{protocol}"][port] = "#{ipaddr}:#{port}"
      close
      puts "localhost:#{port} => #{ipaddr}:#{port} added"
    end

    def delete(protocol, port)
      @inifile["incoming#{protocol}"].delete(port)
      close
      puts "localhost:#{port} => #{port} added"
    end
  end

  def self.port_forward(action, protocol, ipaddr = "", port)
    nat = FusionForward.new(@@natpath)
    case action
      when "add"
        nat.add(protocol, ipaddr, port)
      when "delete"
        nat.delete(protocol, port)
    end
  end
end

option = ARGV[0]
arg1 = ARGV[1]
arg2 = ARGV[2]

def usage
  puts "Usage: fusionmanage <action> <ip address|port> <port>"
end

case option
when "start-network"
  FusionManage.start_network
when "stop-network"
  FusionManage.stop_network
when "restart-network"
  FusionManage.restart_network
when "add-tcp-forward"
  FusionManage.port_forward("add", "tcp", arg1, arg2)
when "delete-tcp-forward"
  FusionManage.port_forward("delete", "tcp", arg1)
when "add-udp-forward"
  FusionManage.port_forward("add", "udp", arg1, arg2)
when "delete-udp-forward"
  FusionManage.port_forward("delete", "udp", arg1)
else
  usage()
  abort()
end
