# frozen_string_literal: true

require_relative 'main'

# Main Meteoservice module
module Meteoservice
  def self.result(city_index = nil)
    doc = if city_index
            Meteoservice::TownsData.auto_process(city_index.to_i)
          else
            Meteoservice::TownsData.process
          end

    puts "\e[H\e[2J"

    weather = Meteoservice::ReadData.from_array(doc[0]).to_a

    puts "#{doc[1]}\n\n"

    weather.each_with_index do |_day, index|
      puts Meteoservice::Predict.new(weather[index])
      puts
    end
  end
end
