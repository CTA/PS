require 'rspec'
require 'factory_girl'
require 'yaml'
require "spec_functions"
require File.dirname(__FILE__)+"/../lib/ps.rb"
connect()
FactoryGirl.find_definitions

