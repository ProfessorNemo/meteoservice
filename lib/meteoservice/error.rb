# frozen_string_literal: true

module Meteoservice
  class Error < StandardError
    ClientError = Class.new(self)
    ServerError = Class.new(self)

    BadRequest = Class.new(ClientError)
    Unauthorized = Class.new(ClientError)
    NotAcceptable = Class.new(ClientError)
    NotFound = Class.new(ClientError)
    Conflict = Class.new(ClientError)
    TooManyRequests = Class.new(ClientError)
    Forbidden = Class.new(ClientError)
    Locked = Class.new(ClientError)
    MethodNotAllowed = Class.new(ClientError)
    NotImplemented = Class.new(ServerError)
    BadGateway = Class.new(ServerError)
    ServiceUnavailable = Class.new(ServerError)
    GatewayTimeout = Class.new(ServerError)

    ERRORS = {
      400 => Meteoservice::Error::BadRequest,
      401 => Meteoservice::Error::Unauthorized,
      403 => Meteoservice::Error::Forbidden,
      404 => Meteoservice::Error::NotFound,
      405 => Meteoservice::Error::MethodNotAllowed,
      406 => Meteoservice::Error::NotAcceptable,
      409 => Meteoservice::Error::Conflict,
      423 => Meteoservice::Error::Locked,
      429 => Meteoservice::Error::TooManyRequests,
      500 => Meteoservice::Error::ServerError,
      502 => Meteoservice::Error::BadGateway,
      503 => Meteoservice::Error::ServiceUnavailable,
      504 => Meteoservice::Error::GatewayTimeout
    }.freeze

    def self.from_response(body)
      msg = body['detail'] || body['message'] || body
      new msg.to_s
    end
  end
end
