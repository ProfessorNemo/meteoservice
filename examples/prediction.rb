# frozen_string_literal: true

require_relative '../lib/main'
require_relative '../lib/meteoservice'

def meteo
  data = nil
  File.open("#{__dir__}/data.json", encoding: 'utf-8') do |f|
    data = JSON.parse(f.read).invert
  end

  data
end

town = 'Мурманск'

if meteo.key?(town)
  Meteoservice.result(meteo[town])
else
  puts "Города с названием \"#{town}\" не существует..."
end
