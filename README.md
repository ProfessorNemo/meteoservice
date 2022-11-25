# `meteoservice`


[![Gem Version](https://img.shields.io/gem/dt/meteoservice.svg)][gem]
[![Gem](https://img.shields.io/gem/v/meteoservice)][gem]
[![Build Status](https://github.com/ProfessorNemo/meteoservice/actions/workflows/ci.yml/badge.svg)][actions]
[![Test Coverage](https://codecov.io/gh/ProfessorNemo/meteoservice/graph/badge.svg)](https://codecov.io/gh/ProfessorNemo/meteoservice)
[![Depfu](https://img.shields.io/depfu/ProfessorNemo/meteoservice?style=flat-square)](https://depfu.com/repos/github/ProfessorNemo/meteoservice)

[gem]: https://rubygems.org/gems/meteoservice
[gem]: https://rubygems.org/gems/meteoservice
[actions]: https://github.com/ProfessorNemo/meteoservice/actions
[coveralls]: https://coveralls.io/r/ProfessorNemo/meteoservice
###### Язык написания - Ruby

## Описание:
> Программа показывает текущую погоду, используя данные в XML-структуре c информационного
> метеоресурса [`Meteoservice`](http://www.meteoservice.ru).
> Пользователю предлагается указать, для какого города он хочет посмотреть прогноз.
> В библиотеке заведен словарик ("towns.json") из 10 городов с уникальными индексами
> (см. [`export.xml`](http://www.meteoservice.ru/content/export.html)). Вы можете продолжить заполнять его,
> используя консольную версию программы, либо завести собственный.

---

## Установка:

Добавьте

``` rb
gem 'meteoservice'
```

И сделайте

  	bundle

Или сделайте

    gem install meteoservice

## Использование:

``` rb
require 'meteoservice'

Meteoservice.result

# Или, если не хотите использовать консоль для ввода данных
# укажите 'id' города в скобках:

Meteoservice.result('113')

(Смотрите пример: [`example`](https://github.com/ProfessorNemo/meteoservice/tree/master/examples))
```

## Пример (вариант с вводом 'id' в консоли):

```
Погоду для какого города Вы хотите узнать?
Введите уникальный индекс города и нажмите "enter". Если вашего города
нет в списке, перейдите по ссылке https://www.meteoservice.ru/content/export.html,
найдите интересуемый индекс и введите его ниже. Название города с индексом добавятся
в список автоматически:

1: ["4", "Архангельск"]
2: ["105", "Калининград"]
3: ["199", "Краснодар"]
4: ["37", "Москва"]
5: ["113", "Мурманск"]
6: ["99", "Новосибирск"]
7: ["111", "Петропавловск-Камчатский"]
8: ["135", "Ростов-на-Дону"]
9: ["69", "Санкт-Петербург"]
69


Санкт-Петербург

Сегодня в среду, вечером
Температура: -4..-2 °С
Ветер: 3..4 м/с, юго-восточный
Атмосферное давление: 763..764 мм.рт.ст.
Облачность: облачно
Осадки:
Интенсивность осадков: возможен дождь/снег
Вероятность грозы: возможна гроза
Относительная влажность воздуха: 61..62 %
Комфорт: -9..-9 °С

2022-11-24 в четверг, ночью
Температура: -4..-4 °С
Ветер: 3..3 м/с, юго-восточный
Атмосферное давление: 764..765 мм.рт.ст.
Облачность: ясно
Осадки:
Интенсивность осадков: возможен дождь/снег
Вероятность грозы: возможна гроза
Относительная влажность воздуха: 61..63 %
Комфорт: -10..-10 °С

2022-11-24 в четверг, утром
Температура: -6..-5 °С
Ветер: 3..3 м/с, юго-восточный
Атмосферное давление: 765..767 мм.рт.ст.
Облачность: ясно
Осадки:
Интенсивность осадков: возможен дождь/снег
Вероятность грозы: возможна гроза
Относительная влажность воздуха: 63..66 %
Комфорт: -11..-11 °С

2022-11-24 в четверг, днём
Температура: -5..-4 °С
Ветер: 3..3 м/с, юго-восточный
Атмосферное давление: 767..768 мм.рт.ст.
Облачность: ясно
Осадки:
Интенсивность осадков: возможен дождь/снег
Вероятность грозы: возможна гроза
Относительная влажность воздуха: 63..66 %
Комфорт: -11..-11 °С

```
