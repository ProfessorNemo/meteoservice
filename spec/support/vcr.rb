# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.uri_parser = Addressable::URI
  c.ignore_hosts 'codeclimate.com'
  # передать один из адаптеров
  c.hook_into :faraday
  # декодироват ответ от сервера, если ответ был правильным образом сжат
  # с помощью одного из алгоритмов
  c.default_cassette_options = {
    decode_compressed_response: true
  }
  # путь, где будут лежать кассеты c ответом
  c.cassette_library_dir = File.join(
    File.dirname(__FILE__), '..', 'fixtures', 'vcr_cassettes'
  )
end
