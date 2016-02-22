require 'yaml'
require 'singleton'

class Configuration
  include Singleton

  def initialize
    @yaml = begin
      YAML.load(File.open "config/game.yml")
    rescue ArgumentError => e
      puts "Could not parse YAML: #{e.message}"
    end
  end

  def get_all_config
    @yaml['config']
  end

  def get_config key
    @yaml['config'][key]
  end

  def get_level number
    @yaml['levels'][number - 1]
  end

  def last_level? number
    number == @yaml['levels'].count
  end

end
