require_relative 'constants'
require_relative 'meteo'

class ReadData
  def self.from_xml(doc)
    forecasts = doc.get_elements('MMWEATHER/REPORT/TOWN/FORECAST').map do |prediction|
      predict_data = {}

      # дата "год, месяц, день, час, день недели"
      data = ::KEYS_DATA.map do |key|
        prediction.attributes[key].to_i
      end

      predict_data[:data] = data

      # атмосферные явления
      phenomena = ::KEYS_PHENOMENA.map do |key|
        prediction.elements['PHENOMENA'].attributes[key].to_i
      end

      predict_data[:phenomena] = phenomena

      # атмосферное давление
      pressure = ::KEYS_LIMIT.map do |key|
        prediction.elements['PRESSURE'].attributes[key].to_i
      end

      predict_data[:pressure] = pressure

      # температура
      temperature = ::KEYS_LIMIT.map do |key|
        prediction.elements['TEMPERATURE'].attributes[key].to_i
      end

      predict_data[:temperature] = temperature

      # относительная влажность воздуха
      relwet = ::KEYS_LIMIT.map do |key|
        prediction.elements['RELWET'].attributes[key].to_i
      end

      predict_data[:relwet] = relwet

      # комфорт - температура воздуха по ощущению одетого по сезону
      # человека, выходящего на улицу
      heat = ::KEYS_LIMIT.map do |key|
        prediction.elements['HEAT'].attributes[key].to_i
      end

      predict_data[:heat] = heat

      # приземный ветер

      max_wind = prediction.elements['WIND'].attributes['max']
      min_wind = prediction.elements['WIND'].attributes['min']
      direction_wind = prediction.elements['WIND'].attributes['direction']

      predict_data[:wind] = [min_wind, max_wind, direction_wind]

      Meteo.new(predict_data)
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
