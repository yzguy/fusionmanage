require 'inifile'

class FusionManage
  class Forward
    attr_reader :inifile
    def initialize(ini_path)
      @inifile = load(ini_path)
    end

    def load(ini_path)
      IniFile.load(ini_path) || abort('Error: inifile not found')
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
      [:tcp, :udp].each do |protocol|
        forwards_by_protocol(protocol)
      end
    end
  end
end
