# frozen_string_literal: true

require_relative 'spec_helper-backend_tpl'

describe 'Given arguments to the asciidoctor-backend_tpl executable', :cli do
  context 'When asking for the Asciidoctor version string' do
    pattern = %(^Asciidoctor Backend Template #{Regexp.escape Asciidoctor::BackendTemplate::VERSION})

    it "should print out version string to stdout if '-V' is used'", :current do
      out, _, res = run_command bin_script('asciidoctor-backend_tpl'), '-V'
      expect(res.exitstatus).to eq 0
      expect(out).to match(/#{pattern}/)
    end

    it "should print out version string to stdout if '-V' and additional argument is used'" do
      out, _, res = run_command bin_script('asciidoctor-backend_tpl'), '-V', '-b backend_tpl'
      expect(res.exitstatus).to eq 0
      expect(out).to match(/#{pattern}/)
    end

    it "should print out version string to stdout if '--version' is used'" do
      out, _, res = run_command bin_script('asciidoctor-backend_tpl'), '--version'
      expect(res.exitstatus).to eq 0
      expect(out).to match(/#{pattern}/)
    end

    it "should print out version string to stdout if '--version' and additional argument is used'" do
      out, _, res = run_command bin_script('asciidoctor-backend_tpl'), '--version', '-b backend_tpl'
      expect(res.exitstatus).to eq 0
      expect(out).to match(/#{pattern}/)
    end

    it "should print out version string to stdout if '-v' is the only argument'" do
      out, _, res = run_command bin_script('asciidoctor-backend_tpl'), '-v'
      expect(res.exitstatus).to eq 0
      expect(out).to match(/#{pattern}/)
    end
  end
end
