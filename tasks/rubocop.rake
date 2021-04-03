# frozen_string_literal: true

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new :lint do |t|
    t.patterns = Dir['lib/**/*.rb'] + Dir['bin/*'] + %w(Rakefile Gemfile *.gemspec .*.rb .simplecov tasks/*.rake spec/**/*.rb)
  end
rescue LoadError => e
  task :lint do
    raise 'Failed to load lint task.
Install required gems using: bundle
Then, invoke Rake using: bundle exec rake', cause: e
  end
end
