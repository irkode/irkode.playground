# frozen_string_literal: true

require_relative 'spec_helper-extension_templates'

describe 'When starting the asciidoctor_templates executable', :cli, :current do
  pattern = %(^Asciidoctor Extension Templates #{Regexp.escape Asciidoctor::ExtensionTemplates::VERSION})

  it 'should print out version and usage information', :current do
    out, _, res = run_command bin_script('asciidoctor-extension_templates')
    expect(res.exitstatus).to eq 0
    expect(out).to match(/#{pattern}/)
  end
end
