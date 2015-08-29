require 'rails_helper'

RSpec.configure do |config|
  Capybara.javascript_driver = :webkit
  config.include SphinxHelpers, type: :feature

  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    # Ensure sphinx directories exist for the test environment
    ThinkingSphinx::Test.init
    # Configure and start Sphinx, and automatically
    # stop Sphinx at the end of the test suite.
    ThinkingSphinx::Test.start_with_autostop
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    # Index data when running an acceptance spec.
    # index
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
    #  index
  end

  config.before(:each) do
    DatabaseCleaner.start
    index
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
