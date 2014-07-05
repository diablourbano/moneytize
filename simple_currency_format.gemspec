# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |gem|
  gem.name = 'simple_currency_format'
  gem.version = SimpleCurrencyFormat::VERSION
  gem.authors = ['DiabloUrbano']
  gem.email = ['andresdavila6@gmail.com']
  gem.description = 'formats any numeric value to the expected currency format, choose dot, comma, space or even ¢ for cents. Just check it!'
  gem.summary = 'format your currency the way you expect.'

  gem.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.test_files = gem.files.grep(/^(tests|spec|features)/)
  gem.require_paths = ['lib']

  # ruby version
  gem.required_ruby_version = '>= 1.9.3'

  if RUBY_VERSION == '1.9.3'
    gem.add_development_dependency 'debugger', '~> 1.6.6'
  elsif RUBY_VERSION >= '2.0.0'
    gem.add_development_dependency 'byebug', '~> 3.1.2'
  end
end
