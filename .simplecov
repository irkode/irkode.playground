# frozen_string_literal: true

SimpleCov.start do
  add_filter %w(/.bundle/ /spec/)
  coverage_dir 'reports/simplecov'
end
