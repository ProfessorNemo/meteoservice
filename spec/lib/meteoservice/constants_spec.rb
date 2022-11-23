# frozen_string_literal: true

RSpec.describe Meteoservice::Constants do
  subject(:const) { described_class }

  it 'constants contain only string variables' do
    expect(const::CLOUDINESS.all?(String)).to be true
    expect(const::PRECIPITATION.all?(String)).to be true
    expect(const::RPOWER.all?(String)).to be true
    expect(const::SPOWER.all?(String)).to be true
    expect(const::WIND_DIRECTION.all?(String)).to be true
    expect(const::DAYS_OF_WEEK.all?(String)).to be true
    expect(const::KEYS_DATA.all?(String)).to be true
    expect(const::KEYS_PHENOMENA.all?(String)).to be true
    expect(const::KEYS_LIMIT.all?(String)).to be true
    expect(const::BASE_URL.instance_of?(String)).to be true
  end

  it 'all constants are frozen' do
    expect(const::CLOUDINESS.frozen?).to be true
    expect(const::PRECIPITATION.frozen?).to be true
    expect(const::RPOWER.frozen?).to be true
    expect(const::SPOWER.frozen?).to be true
    expect(const::WIND_DIRECTION.frozen?).to be true
    expect(const::DAYS_OF_WEEK.frozen?).to be true
    expect(const::KEYS_DATA.frozen?).to be true
    expect(const::KEYS_PHENOMENA.frozen?).to be true
    expect(const::KEYS_LIMIT.frozen?).to be true
    expect(const::BASE_URL.frozen?).to be true
  end
end
