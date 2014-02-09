# -*- encoding: utf-8 -*-
#lib_path = File.expand_path('../lib', __FILE__)
#$LOAD_PATH.push lib_path unless $LOAD_PATH.include?(lib_path)
#require 'mdbe/version'
require File.expand_path('../lib/mdbe/version', __FILE__)

#Gem::Specification.new do |s|
#  s.name          = 'mdbe'
#  s.version       = Mdbe::VERSION
#  s.authors       = ['Matthias Springer', 'Kirstin Heidler', 'Dimitri Korsch', 'Nicco Kunzmann', 'Stefan Bunk', 'JohnnyT']
#  s.email         = ['me@m-sp.org', 'bp2012h1@hpi.uni-potsdam.de']
#  s.homepage      = 'https://github.com/johnnyt/mdbe'
#  s.description   = 'Explore and modify objects in MagLev.'
#  s.summary       = 'A Sinatra app to let you explore and modify objects in MagLev.'
#  s.license       = 'MIT'
#
#  #s.require_paths = ['lib']
#  s.files         = Dir['{lib,public}/**/*'] + %w[ LICENSE.txt README.md app.rb environment.rb config.ru ]
#  #s.test_files    = Dir['test/**/*']
#  s.executables   = ['mdbe']
#
#  #s.add_dependency 'sinatra', '~> 1.4.4'
#  #s.add_dependency 'sinatra-contrib', '~> 1.4.2'
#  #s.add_dependency 'multi_json', '= 1.3.6'
#end

$MDBE = Gem::Specification.new do |gem|
  gem.authors       = ['JohnnyT']
  gem.email         = ['ubergeek3141@gmail.com']
  gem.description   = 'Mdbeualize MagLev'
  gem.summary       = 'Mdbe provides a Sinatra app to let you see and interact with a MagLev enrionment.'
  gem.homepage      = 'https://github.com/johnnyt/mdbe'
  gem.license       = 'MIT'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'mdbe'
  gem.require_paths = ['lib']
  gem.version       = Mdbe::VERSION

  gem.add_dependency 'sinatra', '~> 1.4.4'
  gem.add_dependency 'sinatra-contrib', '~> 1.4.2'
  gem.add_dependency 'multi_json', '= 1.3.6'
end
