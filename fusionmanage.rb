#!/usr/bin/ruby

require_relative('fusionforward.rb')

class FusionManage
  @@fusionbase = 'sudo /Applications/VMware\ Fusion.app/Contents/Library/vmnet-cli'
  @@stop = @@fusionbase + ' --stop'
  @@start = @@fusionbase + ' --start'
  @@natpath = '/Library/Preferences/VMware\ Fusion/vmnet8/nat.conf'

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
