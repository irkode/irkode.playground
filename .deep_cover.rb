# frozen_string_literal: true

DeepCover.configure do
  output 'reports/deep-cover'
  paths %w(lib)
  reporter :text if ENV['CI']
  reporter :istanbul if ENV['DEEP_COVER_REPORTER'] == 'istanbul'
end
