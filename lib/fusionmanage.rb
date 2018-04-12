class FusionManage
  @fusionbase = '/Applications/VMware\ Fusion.app/Contents/Library/vmnet-cli'
  @stop = @fusionbase + ' --stop'
  @start = @fusionbase + ' --start'
  @configure = @fusionbase + ' --configure'
  @nat_path = "/Library/Preferences/VMware\ Fusion/vmnet8/nat.conf"

  def self.start_network
    system @start
  end

  def self.stop_network
    system @stop
  end

  def self.restart_network
    system @start if system @stop
  end

  def self.configure_network
    system @configure
  end

  def self.port_forward(action, protocol, ipaddr = '', port)
    case action
    when 'add'
      Forward.new(@nat_path).add(protocol, ipaddr, port)
    when 'delete'
      Forward.new(@nat_path).delete(protocol, port)
    end
  end

  def self.show_forwards
    Forward.new(@nat_path).show_forwards
  end
end

require 'fusionmanage/forward'
