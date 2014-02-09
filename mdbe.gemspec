# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mdbe/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = 'mdbe'
  s.version       = Mdbe::VERSION
  s.authors       = ['Matthias Springer', 'Kirstin Heidler', 'Dimitri Korsch', 'Nicco Kunzmann', 'Stefan Bunk', 'JohnnyT']
  s.email         = ['me@m-sp.org', 'bp2012h1@hpi.uni-potsdam.de']
  s.homepage      = 'https://github.com/johnnyt/mdbe'
  s.description   = 'Explore and modify objects in MagLev.'
  s.summary       = 'A Sinatra app to let you explore and modify objects in MagLev.'
  s.license       = 'MIT'

  s.require_paths = ['lib']
  s.files         = Dir['{lib,public}/**/*'] + %w[ LICENSE.txt README.md app.rb environment.rb config.ru ]
  s.test_files    = Dir['test/**/*']
  s.executables   = ['mdbe']

  s.add_runtime_dependency 'sinatra', '~> 1.4.4', '>= 1.4.4'
  s.add_runtime_dependency 'sinatra-contrib', '~> 1.4.2', '>= 1.4.2'
  s.add_runtime_dependency 'multi_json', '= 1.3.6'
end
