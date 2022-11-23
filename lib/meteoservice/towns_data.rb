# frozen_string_literal: true

module Meteoservice
  module TownsData
    extend Meteoservice::NestedHashValue
    extend Meteoservice::Constants
    extend Meteoservice::ParserXml

    class << self
      def process
        catalogue = load

        puts <<~TOWNS
          \nПогоду для какого города Вы хотите узнать?
          Введите уникальный индекс города и нажмите "enter". Если вашего города#{' '}
          нет в списке, перейдите по ссылке https://www.meteoservice.ru/content/export.html,
          найдите интересуемый индекс и введите его ниже. Название города с индексом добавятся
          в список автоматически:\n
        TOWNS

        catalogue.sort_by { |_key, value| value }
                 .to_h.each_with_index { |name, index| puts "#{index + 1}: #{name}" }

        city_index = gets.to_i
        path = "/export/gismeteo/point/#{city_index}.xml"
        if catalogue.key?('city_index')
          data_taking(path, city_index)
        else
          data_taking(path, city_index, catalogue, conservation: true)
        end
      end

      def auto_process(city_index)
        path = "/export/gismeteo/point/#{city_index}.xml"

        data_taking(path, city_index)
      end

      private

      def load
        data = nil
        File.open("#{__dir__}/data/towns.json", encoding: 'utf-8') do |f|
          data = JSON.parse(f.read)
        end

        data
      end

      def save(data, index, name)
        File.open("#{__dir__}/data/towns.json", 'w+') do |f|
          f.puts(JSON.pretty_generate(data.merge({ index.to_s => name.to_s })))
        end
      end

      def data_taking(path, index, data = nil, conservation: false)
        result = connection(path)

        city_name = URI.decode_www_form_component(nested_hash_value(result, 'TOWN')['sname'])

        save(data, index, city_name) if conservation

        [nested_hash_value(result, 'FORECAST'), city_name]
      end
    end
  end
end
