RSpec.describe 'SpotHero' do
  describe '::Lot' do
    describe '#find_rate' do
      before :each do
        @lot = SpotHero::Lot.new('specs/test_data.json')
      end
      it 'returns a price when it has valid data and is given valid rates' do
        expect(@lot.find_rate(
          DateTime.parse("2016-10-23T10:00:00Z"),
          DateTime.parse("2016-10-23T18:00:00Z")
        )).to eq('2000')
        expect(@lot.find_rate(
          DateTime.parse("2016-10-25T10:00:00Z"),
          DateTime.parse("2016-10-25T18:00:00Z")
        )).to eq('1500')
      end
      it 'returns unavailable if there is no rate info for time given' do
        expect(@lot.find_rate(
          DateTime.parse("2016-10-23T06:00:00Z"),
          DateTime.parse("2016-10-23T08:00:00Z")
        )).to eq('unavailable')
      end
      it 'returns properly on edge cases' do
        expect(@lot.find_rate(
          DateTime.parse("2016-10-21T09:00:00Z"),
          DateTime.parse("2016-10-21T21:00:00Z")
        )).to eq('2000')
        expect(@lot.find_rate(
          DateTime.parse("2016-10-23T09:00:00Z"),
          DateTime.parse("2016-10-23T21:01:00Z")
        )).to eq('unavailable')
      end
      context 'with invalid data' do
        it 'raises a FileError when there is conflicting data for dates' do
          lot = SpotHero::Lot.new('specs/invalid_test_data.json')
          expect{ lot.find_rate(
            DateTime.parse("2016-10-24T09:00:00Z"),
            DateTime.parse("2016-10-24T21:00:00Z")
          ) }.to raise_error(SpotHero::FileError)
        end
      end
    end
    describe '#validate_date_times' do
      before :each do
        @lot = SpotHero::Lot.new('specs/test_data.json')
      end
      it 'raises a DateError with invalid dates' do
        expect{
          @lot.send(
            :validate_date_times,
            DateTime.parse("2016-10-23T09:00:00Z"),
            DateTime.parse("2016-10-24T015:00:00Z")
          )
        }.to raise_error(SpotHero::DateError)
      end
      it 'raises a TimeError with invalid times' do
        expect{
          @lot.send(
            :validate_date_times,
            DateTime.parse("2016-10-23T09:00:00Z"),
            DateTime.parse("2016-10-23T07:00:00Z")
          )
        }.to raise_error(SpotHero::TimeError)
      end
      it 'does nothing if dates and times are valid' do
        expect{
          @lot.send(
            :validate_date_times,
            DateTime.parse("2016-10-23T09:00:00Z"),
            DateTime.parse("2016-10-23T18:00:00Z")
          )
        }.to_not raise_error
      end
    end
  end
end
