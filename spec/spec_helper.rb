require_relative '../boot'

class Constants
  BOTONERA_DIR_PATH = "#{__dir__}/fixtures".freeze
  SOUNDS_DIR_PATH   = "#{BOTONERA_DIR_PATH}/sounds".freeze
  BUTTONS_FILE_PATH = "#{BOTONERA_DIR_PATH}/buttons.json".freeze
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
