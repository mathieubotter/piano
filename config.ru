require 'rubygems'
require 'bundler'

Bundler.require

require File.expand_path(File.dirname(__FILE__) + '/app/piano')
run Piano::App
