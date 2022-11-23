# frozen_string_literal: true

module Meteoservice
  class ReadData
    def self.from_array(doc)
      include Meteoservice::Constants

      forecasts = doc.map do |prediction|
        predict_data = {}

        # дата "год, месяц, день, час, день недели"
        data = KEYS_DATA.map do |key|
          prediction[key].to_i
        end

        predict_data[:data] = data

        # атмосферные явления
        phenomena = KEYS_PHENOMENA.map do |key|
          prediction['PHENOMENA'][key].to_i
        end

        predict_data[:phenomena] = phenomena

        # атмосферное давление
        pressure = KEYS_LIMIT.map do |key|
          prediction['PRESSURE'][key].to_i
        end

        predict_data[:pressure] = pressure

        # температура
        temperature = KEYS_LIMIT.map do |key|
          prediction['TEMPERATURE'][key].to_i
        end

        predict_data[:temperature] = temperature

        # относительная влажность воздуха
        relwet = KEYS_LIMIT.map do |key|
          prediction['RELWET'][key].to_i
        end

        predict_data[:relwet] = relwet

        # комфорт - температура воздуха по ощущению одетого по сезону
        # человека, выходящего на улицу
        heat = KEYS_LIMIT.map do |key|
          prediction['HEAT'][key].to_i
        end

        predict_data[:heat] = heat

        # приземный ветер
        max_wind = prediction['WIND']['max']
        min_wind = prediction['WIND']['min']
        direction_wind = prediction['WIND']['direction']

        predict_data[:wind] = [min_wind, max_wind, direction_wind]

        Meteoservice::Meteo.new(predict_data)
      end

      new(forecasts)
    end

    def initialize(forecasts)
      @forecasts = forecasts
    end

    def to_a
      @forecasts
    end
  end
end
