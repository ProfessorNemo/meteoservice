#!/usr/bin/env ruby

# Программа «Прогноз погоды»
# Данные берем из XML метеосервиса
# http://www.meteoservice.ru/content/export.html

# Подключаем константы и классы
PW = 'lib/'.freeze
%W[#{PW}constants #{PW}read_data #{PW}predict #{PW}weather].each do |file|
  require_relative file
end

BASE_URL = 'https://www.meteoservice.ru/content/export'.freeze

puts 'Введите название города на русском:'
town = $stdin.gets.strip

town = %w[СПБ СПб Спб спб].include?(town) ? 'Санкт-Петербург' : town.split(/(-)/).map(&:capitalize).join

sky = Weather.new(town)
weather = sky.xml_predict.weather[0]
city = sky.city

# очистить экран
puts "\e[H\e[2J"

puts "#{city[:city_name]}\n\n"

weather.each_with_index do |_sky, index|
  puts Predict.new(weather[index])
  puts
end

# Вывести страну
# puts sky.region.country