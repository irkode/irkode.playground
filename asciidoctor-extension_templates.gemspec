# frozen_string_literal: true

begin
  require_relative 'lib/asciidoctor/extension_templates/version'
rescue LoadError
  require 'asciidoctor/extension_templates/version'
end

Gem::Specification.new do |spec|
  spec.name = 'asciidoctor-extension_templates'
  spec.version = Asciidoctor::ExtensionTemplates::VERSION
  spec.summary = 'Extension templates for Asciidoctor'
  spec.description = 'Collection of Templates for Asciidoctor extensions in Ruby'
  spec.authors = ['irkode']
  spec.email = '79966571+irkode@users.noreply.github.com'
  spec.homepage = 'https://github.com/irkode/irkode.playground'
  spec.license = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new '>= 2.7.2'

  spec.metadata = {
    'homepage_uri' => spec.homepage,
    'bug_tracker_uri' => 'https://github.com/irkode/irkode.playground/issues',
    #'changelog_uri' => 'CHANGELOG.adoc',
    'source_code_uri' => 'https://github.com/irkode/irkode.playground',
  }

  # NOTE: the logic to build the list of files is designed to produce a usable package even when the git command is not available
  begin
    files = (result = `git ls-files -z`.split ?\0).empty? ? Dir['**/*'] : result
  rescue
    files = Dir['**/*']
  end
  spec.files = files.grep %r/^(?:(?:lib)\/.+|(?:CHANGELOG|LICENSE)\.adoc|#{spec.name}\.gemspec)$/
  spec.executables = (files.grep %r/^bin\//).map {|f| File.basename f }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'asciidoctor', '~> 2.0'
  spec.add_development_dependency 'solargraph', '~> 0.4'
end
