# frozen_string_literal: true

module Meteoservice
  module ParserXml
    include Meteoservice::Constants

    def connection(path)
      connection = Faraday.new(url: BASE_URL) do |faraday|
        faraday.request :xml, content_type: /\bxml$/
        faraday.adapter Faraday.default_adapter
        faraday.response :xml
      end

      response ||= connection.get(path)
    rescue Faraday::Error => e
      puts "Ошибка соединения с сервером: #{e.message}"
      abort e.message
    else
      begin
        body = response.body
      rescue StandardError => e
        puts e.class.name
        abort e.message
      else
        respond_with_error(response.status, body) unless response.success?
        body
      end
    end

    private

    # code - это код состояния HTTP (504, 429, 404...)
    def respond_with_error(code, body)
      raise(Meteoservice::Error, body) unless Meteoservice::Error::ERRORS.key?(code)

      raise Meteoservice::Error::ERRORS[code].from_response(body)
    end
  end
end
