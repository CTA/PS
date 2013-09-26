require 'simplecov'

SimpleCov.start do
  add_filter "/spec"
  root File.dirname(__FILE__)+"/.."

  add_group "PsObjects", "lib/ps/objects"
  add_group "core" do |file|
    !file.filename.include?("objects")
  end
end


require 'rspec'
require 'factory_girl'
require 'yaml'
require "spec_functions"
require File.dirname(__FILE__)+"/../lib/ps.rb"

SimpleCov.command_name "ps"

FactoryGirl.find_definitions
