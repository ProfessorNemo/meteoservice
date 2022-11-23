# frozen_string_literal: true

module Meteoservice
  class Meteo
    attr_reader :data, :phenomena, :pressure, :temperature, :wind,
                :relwet, :heat

    def initialize(tags)
      @data = tags[:data]
      @phenomena = tags[:phenomena]
      @pressure = tags[:pressure]
      @temperature = tags[:temperature]
      @wind = tags[:wind]
      @relwet = tags[:relwet]
      @heat = tags[:heat]
    end
  end
end
