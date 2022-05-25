# Подключаем библиотеку для загрузки данных по http-протоколу
require 'net/http'

# Подключаем библиотеку для парсинга XML
require 'rexml/document'

# Подключаем библиотеку для парсинга HTML
require 'nokogiri'

require 'open-uri'

class Weather
  attr_accessor :town, :weather, :city, :country

  def initialize(town)
    @town = town
    @weather = []
    @city = {}
  end

  # получаем XML-файл с прогнозом
  def xml_predict
    [*1..100_000].map do |id|
      uri = URI.parse("https://xml.meteoservice.ru/export/gismeteo/point/#{id}.xml")
      # Отправляем HTTP-запрос по указанному адресу и записываем ответ в переменную response.
      response = Net::HTTP.get_response(uri)
      next if response.body.size == 46

      # Из тела ответа (body) формируем XML документ с помощью REXML парсера
      doc = REXML::Document.new(response.body)
      # Получаем имя города из XML, город лежит в ноде REPORT/TOWN
      city_name = URI.decode_www_form_component(doc.root.elements['REPORT/TOWN'].attributes['sname'])

      next if city_name.scan(town).empty?

      @weather << ReadData.from_xml(doc).to_a
      # Получаем уникальный идентификатор города
      id = URI.decode_www_form_component(doc.root.elements['REPORT/TOWN'].attributes['index'])
      @city.merge!({ city_name: city_name, city_id: id })
      break
    end
    self
  end

  # по желанию пользователя ввести вручную и
  # подтвердить существование страны и правильность ввода
  def region
    puts 'Введите название страны:'
    nation = $stdin.gets.strip
                   .split(/(-)/)
                   .map(&:capitalize)
                   .join

    page = Nokogiri::HTML(URI.parse(::BASE_URL).read)

    countrys = page.css('div .bordered select').map { |i| i.children.text.split("\n") }
    countrys = countrys[0]
               .map { |str| str.gsub(/\s+/, '') }
               .reject(&:empty?)
    @country = countrys
               .filter_map { |land| land.scan(nation).empty? ? nil : land }
               .join

    raise ArgumentError, " Такой страны \"#{nation}\" не существует" if country.empty?

    self
  end

  def to_s
    country.to_s
  end
end
