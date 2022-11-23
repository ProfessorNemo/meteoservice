module Meteoservice
  class Predict
    include Meteoservice::Constants

    def initialize(forecasts)
      @date = forecasts.data
      @phenomena = forecasts.phenomena
      @pressure = forecasts.pressure
      @temperature = forecasts.temperature
      @wind = forecasts.wind
      @relwet = forecasts.relwet
      @heat = forecasts.heat
    end

    # Какой день недели?
    def day_week
      firstday_wday = Date.new(@date[0], @date[1], @date[2]).wday

      firstday_wday = 7 if firstday_wday.zero?

      DAYS_OF_WEEK[firstday_wday - 1]
    end

    # Вывод результата в терминал
    def to_s
      times_day = 'ночью' if Range.new(*[0, 5].map(&:to_i)).include? @date[3]
      times_day = 'утром' if Range.new(*[6, 12].map(&:to_i)).include? @date[3]
      times_day = 'днём' if Range.new(*[13, 17].map(&:to_i)).include? @date[3]
      times_day = 'вечером' if Range.new(*[18, 23].map(&:to_i)).include? @date[3]

      result = if today?
                 "Сегодня во #{day_week}, #{times_day}\n" if day_week == "вторник"
                 "Сегодня в #{day_week}, #{times_day}\n" unless day_week == "вторник"
               else
                 "#{DateTime.new(@date[0], @date[1], @date[2], @date[3], 0, 0)
          .strftime('%F')} в #{day_week} #{times_day}\n"
               end

      result << "Температура: #{temperature_range_string} °С\n" \
        "Ветер: #{@wind[0]}..#{@wind[1]} м/с, #{WIND_DIRECTION[@wind[2].to_i]}\n" \
        "Атмосферное давление: #{@pressure[0]}..#{@pressure[1]} мм.рт.ст.\n" \
        "Облачность: #{CLOUDINESS[@phenomena[0].to_i]}\n" \
        "Осадки: #{PRECIPITATION[@phenomena[1].to_i]}\n" \
        "Интенсивность осадков: #{RPOWER[@phenomena[2].to_i]}\n" \
        "Вероятность грозы: #{SPOWER[@phenomena[3].to_i]}\n" \
        "Относительная влажность воздуха: #{@relwet[0]}..#{@relwet[1]} %\n" \
        "Комфорт: #{@heat[0]}..#{@heat[1]} °С"

      result
    end

    # Добавим знак "+" к температуре, если она положительная
    def temperature_range_string
      result = ''
      result << '+' if @temperature[0].positive?
      result << "#{@temperature[0]}.."
      result << '+' if @temperature[1].positive?
      result << @temperature[1].to_s
      result
    end

    def today?
      Date.today.strftime("%d") == @date[2].to_s
    end
  end
end
