#! /usr/bin/env ruby

require './src/game'
require './src/configuration'

options = Configuration.instance.get_all_config
window = GameWindow.new options
window.show
