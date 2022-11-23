# frozen_string_literal: true

module Box
  module Parser
    class << self
      BASE_URL = 'https://xml.meteoservice.ru'

      def call(path)
        connection = Faraday.new(url: BASE_URL) do |faraday|
          faraday.request :xml, content_type: /\bxml$/
          faraday.adapter Faraday.default_adapter
          faraday.response :xml
        end

        response ||= connection.get(path)
        response.body
      end
    end
  end
end
