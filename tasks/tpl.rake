# frozen_string_literal: true

require 'yaml'

task :tpl, [:message] do |_, args|
  args.message && puts(args.message)
  puts 'USAGE: tpl:<command>[<args>]
  tpl:backend[target,backend,class] - create a new backend from template
'
  exit
end

namespace 'tpl' do
  require 'rake/file_list'

  @resource_files_edit = Rake::FileList['resources/gemspec-template', 'resources/README.adoc']
  @common_files = Rake::FileList['Rakefile', 'Gemfile', '.*.rb', '.rspec', '.*.yml', '.simplecov', 'tasks/*', 'resources/*'] - @resource_files_edit

  task :check_args, [:target, :shortname, :classname] do |_, args|
    Rake::Task[:tpl].invoke 'ERROR: missing arguments!' unless args.target && args.shortname
    @short_name = args.shortname
    @class_name = args.classname || @short_name.capitalize
    @target_folder = %(#{args.target}/asciidoctor-#{@short_name})
    #Rake::Task[:tpl].invoke "ERROR: target '#{@target_folder}' already exists! Remove and retry" if File.exist? @target_folder
  end

  task :copy_common do
    # reversing to reduce number of mkdir_p calls
    puts 'copy common files...'
    [@common_files].flatten.reverse_each do |source_file|
      target_file = File.join @target_folder, source_file.gsub(@template_mode, @short_name).gsub('resources/', '')
      target_file_path = File.split(target_file)[0]

      mkdir_p target_file_path unless File.directory? target_file_path
      cp source_file, target_file
    end

    @resource_files_edit.each do |source_file|
      target_file = File.join @target_folder, source_file.gsub(@template_mode, @short_name).gsub('resources/', '').gsub('gemspec-template', "asciidoctor-#{@short_name}.gemspec")
      puts %(create: #{target_file})
      File.write target_file, File.read(source_file).gsub('{short-name}', @short_name).gsub('{class-name}', @class_name)
    end
  end

  task install_backend: [:set_backend, :copy_common] do
    # reversing to reduce number of mkdir_p calls
    puts 'installing backend files:'
    @source_files.reverse_each do |source_file|
      target_file = File.join @target_folder, source_file.gsub(@template_mode, @short_name).gsub('resources/', '').gsub('gemspec-template', "asciidoctor-#{@short_name}.gemspec")
      target_file_path = File.split(target_file)[0]

      mkdir_p target_file_path unless File.directory? target_file_path
      File.write target_file, File.read(source_file)
                                  .gsub(@template_mode, @short_name)
                                  .gsub('BackendTemplate', @class_name)
                                  .gsub('Backend Template', "Backend #{@class_name}")
                                  .gsub('extension_templates', @short_name)
    end
    FileUtils.chmod 0o755, File.join(@target_folder, "bin/asciidoctor-#{@short_name}")
  end

  task :set_backend do
    @template_mode = 'backend_tpl'
    @source_files =
      Rake::FileList[
          "lib/**/*#{@template_mode}.rb",
          "lib/asciidoctor/#{@template_mode}/**",
          "spec/**/*#{@template_mode}*.rb",
          "spec/#{@template_mode}/**",
          'spec/spec_helper.rb',
          "bin/asciidoctor-#{@template_mode}",
      ]
  end

  desc 'create new backend from template'
  task :backend, [:target, :shortname, :classname] => [:check_args, :install_backend] do
    puts %(Installed new Backend '#{@class_name}' to folder '#{@target_folder}')
  end
end
