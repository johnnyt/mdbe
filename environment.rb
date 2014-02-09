ENV['RACK_ENV'] ||= 'development'
ENV['RACK_ROOT'] = RACK_ROOT = File.expand_path('..', __FILE__)
require 'sinatra/base'
require 'sinatra/json'
#require 'sinatra/namespace'
require 'multi_json'

require File.expand_path '../lib/mdbe', __FILE__
