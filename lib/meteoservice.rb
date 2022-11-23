# frozen_string_literal: true

require_relative 'main'

# Main Meteoservice module
module Meteoservice
  def self.result
    doc = Meteoservice::TownsData.process

    # очистить экран
    puts "\e[H\e[2J"

    weather = Meteoservice::ReadData.from_array(doc[0]).to_a

    puts "#{doc[1]}\n\n"

    weather.each_with_index do |_day, index|
      puts Meteoservice::Predict.new(weather[index])
      puts
    end
  end
end

Meteoservice.result
