# frozen_string_literal: true

require File.expand_path('lib/open_sea/version', __dir__)

Gem::Specification.new do |s|
  s.name        = 'open_sea'
  s.version     = OpenSea::VERSION
  s.summary     = 'OpenSea API'
  s.description = 'Ruby Client for interacting with OpenSea API'
  s.authors     = ['Brent Raines']
  s.email       = 'bt.raines@gmail.com'
  s.files       = ['lib/**/*']
  s.homepage    = 'https://rubygems.org/gems/open_sea_api'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 2.7.3'

  s.add_dependency 'json', '~> 2.6'

  s.add_development_dependency 'pry', '~> 0.14'
  s.add_development_dependency 'rspec', '~> 3.10'
  s.add_development_dependency 'rubocop', '~> 1.23'
  s.add_development_dependency 'rubocop-performance', '~> 1.12'
  s.add_development_dependency 'rubocop-rspec', '~> 2.6'
  s.add_development_dependency 'webmock', '~> 3.14'
end
