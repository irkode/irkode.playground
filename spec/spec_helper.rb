# frozen_string_literal: true

# taken from asciidoctor-pdf/spec/spec_helper.rb and adopted

# TODO: no coverage yet - have to find out how
case ENV['COVERAGE']
when 'deep'
  ENV['DEEP_COVER'] = 'true'
  require 'deep_cover'
when 'true'
  require 'deep_cover/builtin_takeover'
  require 'simplecov'
end

require 'open3' unless defined? Open3

RSpec.configure do
  def bin_script name, opts = {}
    bin_path = Gem.bin_path (opts.fetch :gem, 'asciidoctor-extension_templates'), name
    if (defined? DeepCover) && !(DeepCover.const_defined? :TAKEOVER_IS_ON)
      [Gem.ruby, '-rdeep_cover', bin_path]
    elsif Gem.win_platform?
      [Gem.ruby, bin_path]
    else
      bin_path
    end
  end

  def run_command cmd, *args
    Dir.chdir __dir__ do
      if Array === cmd
        args.unshift(*cmd)
        cmd = args.shift
      end
      kw_args = Hash === args[-1] ? args.pop : {}
      env_override = kw_args[:env] || {}
      unless kw_args[:use_bundler]
        env_override['RUBYOPT'] = nil
        if defined? Bundler
          rubylib = []
          env_override['RUBYLIB'] = rubylib.join File::PATH_SEPARATOR unless rubylib.empty?
        end
      end
      if (out = kw_args[:out])
        Open3.pipeline_w([env_override, cmd, *args, { out: out }]) {}
      else
        Open3.capture3 env_override, cmd, *args
      end
    end
  end
end
