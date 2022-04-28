#!/usr/bin/env ruby

# Программа «Прогноз погоды»

# Данные берем из XML метеосервиса
# http://www.meteoservice.ru/content/export.html

# Подключаем библиотеку для работы c адресами URI
require 'uri'

# Подключаем библиотеку для загрузки данных по http-протоколу
require 'net/http'

# Подключаем библиотеку для парсинга XML
require 'rexml/document'

# Подключаем библиотеку для работы с датами и временем
require 'date'

# Подключаем константы и классы
PW = 'lib/'.freeze
%W[#{PW}constants #{PW}read_data #{PW}predict].each do |file|
  require_relative file
end

# массив из названий городов, взяв ключи массива CITIES
city_names = CITIES.keys

# Спрашиваем у пользователя, какой город по порядку ему нужен
puts 'Погоду для какого города Вы хотите узнать?'
city_names.each_with_index { |name, index| puts "#{index + 1}: #{name}" }
city_index = gets.to_i
until city_index.between?(1, city_names.size)
  city_index = gets.to_i
  puts "Введите число от 1 до #{city_names.size}"
end

# очистить экран
puts "\e[H\e[2J"

# Когда, наконец, получим нужный индекс, достаем city_id
city_id = CITIES[city_names[city_index - 1]]

# Сформируем адрес запроса с сайта метеосервиса
# 69 - СПб, адрес для своего города можно получить здесь:
# https://www.meteoservice.ru/content/export
uri = URI.parse("https://xml.meteoservice.ru/export/gismeteo/point/#{city_id}.xml")

# Отправляем HTTP-запрос по указанному адресу и записываем ответ в переменную response.
response = Net::HTTP.get_response(uri)

# Из тела ответа (body) формируем XML документ с помощью REXML парсера
doc = REXML::Document.new(response.body)

# Получаем имя города из XML, город лежит в ноде REPORT/TOWN
city_name = URI.decode_www_form_component(
  doc.root.elements['REPORT/TOWN'].attributes['sname']
)

weather = ReadData.from_xml(doc).to_a

puts "#{city_name}\n\n"

weather.each_with_index do |_day, index|
  puts Predict.new(weather[index])
  puts
end

# DateTime.new(year,month, day, hour, min, sec).strftime('%F %H:%M')
