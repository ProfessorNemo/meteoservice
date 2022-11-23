# frozen_string_literal: true

module Meteoservice
  module Constants
    # Облачность
    CLOUDINESS = %w[туман ясно малооблачно облачно пасмурно].freeze

    # Осадки
    PRECIPITATION = %w[смешанные дождь ливень снег гроза нет данных без осадков].freeze

    # Интенсивность осадков, если они есть
    RPOWER = ['возможен дождь/снег', 'дождь/снег'].freeze

    # Вероятность грозы, если прогнозируется
    SPOWER = ['возможна гроза', 'гроза'].freeze

    # Ветер (направление)
    WIND_DIRECTION = %w[северный северо-восточный восточный юго-восточный южный
                        юго-западный западный северо-западный].freeze

    # Дни недели
    DAYS_OF_WEEK = %w[понедельник вторник среду четверг пятницу субботу воскресенье].freeze

    # аттрибуты xml
    KEYS_DATA = %w[year month day hour weekday].freeze

    # Погодные явления
    KEYS_PHENOMENA = %w[cloudiness precipitation rpower spower].freeze

    KEYS_LIMIT = %w[min max].freeze

    BASE_URL = 'https://xml.meteoservice.ru'
  end
end
