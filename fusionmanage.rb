#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

require 'inifile'

class FusionManage
  @@fusionbase = '/Applications/VMware\ Fusion.app/Contents/Library/vmnet-cli'
  @@stop = @@fusionbase + ' --stop'
  @@start = @@fusionbase + ' --start'
  @@nat_path = "/Library/Preferences/VMware\ Fusion/vmnet8/nat.conf"

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
    attr_reader :inifile
    def initialize(ini_path)
      @inifile = load(ini_path)
    end

    def load(ini_path)
      IniFile.load(ini_path) or abort("Error: inifile not found")
    end

    def save
      inifile.write
    end

    def add(protocol, ipaddr, port)
      inifile["incoming#{protocol}"][port] = "#{ipaddr}:#{port}"
    ensure
      save
    end

    def delete(protocol, port)
      inifile["incoming#{protocol}"].delete(port)
    ensure
      save
    end

    def forwards_by_protocol(protocol)
      puts "#{protocol.upcase} Forwards"
      inifile["incoming#{protocol}"].each do |key, val|
        puts "#{key} => #{val}"
      end
      puts
    end

    def show_forwards
      ['tcp', 'udp'].each do |protocol|
        forwards_by_protocol(protocol)
      end
    end
  end

  def self.port_forward(action, protocol, ipaddr = "", port)
    case action
      when "add"
        FusionForward.new(@@nat_path).add(protocol, ipaddr, port)
      when "delete"
        FusionForward.new(@@nat_path).delete(protocol, port)
    end
  end

  def self.show_forwards
    FusionForward.new(@@nat_path).show_forwards
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
