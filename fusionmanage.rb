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
      puts "ADDED: #{port} => #{ipaddr}:#{port}"
      puts "Restart VMware Fusion Networking to take effect"
    end

    def delete(protocol, port)
      @inifile["incoming#{protocol}"].delete(port)
      close
      puts "DELETED: #{port} => #{port}"
      puts "Restart VMware Fusion Networking to take effect"
    end

    def show 
      puts "TCP Port Forwards"
      puts "================="
      @inifile['incomingtcp'].each do |key, val|
        puts "#{key} => #{val}"
      end
      puts ""
      puts "UDP Port Forwards"
      puts "================="
      @inifile['incomingudp'].each do |key, val|
        puts "#{key} => #{val}"
      end
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

  def self.show_forwards
    nat = FusionForward.new(@@natpath)
    nat.show
  end
end

option = ARGV[0]
arg1 = ARGV[1]
arg2 = ARGV[2]

def usage
  puts %{Usage: fusionmanage <action> <ip address|port> <port>"

Actions:
start-network         - Start VMware Fusion Networking
stop-network          - Stop VMware Fusion Networking
restart-network       - Restart VMware Fusion Networking
show-forwards         - Show All Current Port Forwards

Port Forwarding:
add-tcp-forward
add-udp-forward
  IP Address         - IP Address of VM to forward traffic to 
  Port               - Port to forward traffic to

Example: fusionmanage add-tcp-forward 192.168.0.10 8080

delete-tcp-forward
delete-udp-forward
  Port               - Port to delete forwarding on 

Example: fusionmanage delete-tcp-forward 8080
}
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
when "show-forwards"
  FusionManage.show_forwards
else
  usage()
  abort()
end
