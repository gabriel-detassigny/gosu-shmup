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

  def get_all
    @yaml['config']
  end

  def get key
    @yaml['config'][key]
  end

end
