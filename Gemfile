# frozen_string_literal: true

source 'https://rubygems.org'

# Look in {gem-name}.gemspec for runtime and development dependencies
gemspec

gem 'asciidoctor', ENV['ASCIIDOCTOR_VERSION'], require: false if ENV.key? 'ASCIIDOCTOR_VERSION'

group :docs do
  gem 'rouge', ENV['ROUGE_VERSION'], require: false if ENV.key? 'ROUGE_VERSION'
end

group :lint do
  gem 'rubocop', '~> 1.11.0', require: false
  gem 'rubocop-rake', '~> 0.5.0', require: false
  gem 'rubocop-rspec', '~> 2.2.0', require: false
end

group :test do
  gem 'rake', '~> 13.0', require: false
  gem 'rspec', '~> 3.10', require: false
end

group :coverage do
  gem 'deep-cover-core', '~> 1.1.0', require: false
  gem 'simplecov', '~> 0.21.0', require: false
  gem 'terminal-table', '~>3.0.0', require: false
end
