# frozen_string_literal: true

require 'simplecov'
require 'webmock/rspec'

# Запуск измерителя покрытия кода тестами с игнорированием некоторых директорий:
SimpleCov.start do
  add_filter 'spec/'
  add_filter '.github/'
  add_filter 'examples/'
end

# Если тесты работают на "Continuous Integration", то данные затем отрпавить на сервис "Codecov"
if ENV['CI'] == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require_relative '../lib/main'
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  WebMock.allow_net_connect!

  WebMock::API.prepend(Module.new do
    extend self
    def stub_request(*args)
      # Выключаем VCR в тех случаях, когда работает WebMock и наоборот
      VCR.turn_off!
      super
    end
  end)

  config.before { VCR.turn_on! }
end
