# frozen_string_literal: true

RSpec.describe Meteoservice::ParserXml do
  let(:path) { '/export/gismeteo/point/37.xml' }
  let(:full_path) { 'https://xml.meteoservice.ru/export/gismeteo/point/69.xml' }
  let(:dummy) { Class.new { include Meteoservice::ParserXml }.new }

  let(:result) do
    { "MMWEATHER" =>
      { "REPORT" =>
        { "TOWN" =>
          { "FORECAST" =>
            [{ "PHENOMENA" => { "cloudiness" => "2", "precipitation" => "6", "rpower" => "0", "spower" => "0" },
               "PRESSURE" => { "max" => "757", "min" => "756" },
               "TEMPERATURE" => { "max" => "0", "min" => "-0" },
               "WIND" => { "min" => "4", "max" => "6", "direction" => "3" },
               "RELWET" => { "max" => "62", "min" => "61" },
               "HEAT" => { "min" => "-7", "max" => "-7" },
               "day" => "22", "month" => "11", "year" => "2022", "hour" => "15", "tod" => "2", "predict" => "0", "weekday" => "3" }] } } } }
  end

  let(:body) do
    <<-XML
        <?xml version="1.0" encoding="utf-8"?>
        <MMWEATHER>
            <REPORT type="frc3">
                <TOWN index="69" sname="%D0%A1%D0%B0%D0%BD%D0%BA%D1%82-%D0%9F%D0%B5%D1%82%D0%B5%D1%80%D0%B1%D1%83%D1%80%D0%B3" latitude="60" longitude="30">
                    <FORECAST day="23" month="11" year="2022" hour="03" tod="0" predict="0" weekday="4">
                        <PHENOMENA cloudiness="3" precipitation="10" rpower="0" spower="0"/>
                        <PRESSURE max="761" min="761"/>
                        <TEMPERATURE max="-2" min="-3"/>
                        <WIND min="3" max="4" direction="2"/>
                        <RELWET max="66" min="62"/>
                        <HEAT min="-8" max="-8"/>
                    </FORECAST>
                    <FORECAST day="23" month="11" year="2022" hour="09" tod="1" predict="0" weekday="4">
                        <PHENOMENA cloudiness="3" precipitation="10" rpower="0" spower="0"/>
                        <PRESSURE max="762" min="761"/>
                        <TEMPERATURE max="-2" min="-2"/>
                        <WIND min="4" max="4" direction="2"/>
                        <RELWET max="66" min="65"/>
                        <HEAT min="-9" max="-9"/>
                    </FORECAST>
                    <FORECAST day="23" month="11" year="2022" hour="15" tod="2" predict="0" weekday="4">
                        <PHENOMENA cloudiness="3" precipitation="10" rpower="0" spower="0"/>
                        <PRESSURE max="762" min="762"/>
                        <TEMPERATURE max="-2" min="-2"/>
                        <WIND min="4" max="4" direction="3"/>
                        <RELWET max="65" min="64"/>
                        <HEAT min="-8" max="-8"/>
                    </FORECAST>
                    <FORECAST day="23" month="11" year="2022" hour="21" tod="3" predict="0" weekday="4">
                        <PHENOMENA cloudiness="3" precipitation="10" rpower="0" spower="0"/>
                        <PRESSURE max="764" min="763"/>
                        <TEMPERATURE max="-2" min="-3"/>
                        <WIND min="3" max="4" direction="3"/>
                        <RELWET max="65" min="63"/>
                        <HEAT min="-8" max="-8"/>
                    </FORECAST>
                </TOWN>
            </REPORT>
        </MMWEATHER>
    XML
  end

  describe '#connection' do
    it 'when path exist' do
      allow(dummy).to receive(:connection).with(path).and_return(result)
      expect(dummy.connection(path)).to eq(result)
    end

    it 'wrong Way' do
      allow(dummy).to receive(:connection).with('http://does not exist').and_raise(Meteoservice::Error::ServerError)
      expect { dummy.connection('http://does not exist') }.to raise_error(Meteoservice::Error::ServerError)
    end

    it 'raises an error with invalid path' do
      stub_request(:get, 'http://does not exist')
        .to_raise(StandardError)

      expect { dummy.connection('http://does not exist') }.to raise_error(StandardError)
    end

    it 'when response is badly' do
      stub = stub_request(:get, full_path)
             .with(
               headers: {
                 'referer' => 'https://www.meteoservice.ru/',
                 'Accept' => 'application/xml',
                 'Accept-Encoding' => 'gzip, deflate, br',
                 'User-Agent' => 'Ruby'
               }
             )
             .to_return(status: 200, body: body, headers: {})

      #  strange behavior
      expect(stub).not_to have_been_requested
    end
  end
end
