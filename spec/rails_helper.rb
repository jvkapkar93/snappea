require File.expand_path('../../config/environment', __FILE__)
#require 'rails/test_help'
# require database cleaner at the top level
require 'database_cleaner'
require 'shoulda-matchers'
require 'factory_girl_rails'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
# [...]
RSpec.configuration do |config|
  # [...]
  config.include RequestSpecHelper, type: :request
  # add `FactoryGirl` methods
  config.include FactoryGirl::Syntax::Methods

  # start by truncating all the tables but then use the faster transaction strategy the rest of the time.
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
    FactoryGirl.find_definitions
  end

  RSpec.configure do |config|
    config.include FactoryGirl::Syntax::Methods
  end


  # start the transaction strategy as examples are run
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
  # [...]
end

# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
# # [...]
# RSpec.configuration do |config|
#   # [...]
#   config.include RequestSpecHelper, type: :request
#   # [...]
# end