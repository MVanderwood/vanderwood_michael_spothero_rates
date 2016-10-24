RSpec.describe 'SpotHero' do
  describe '::Rate' do
    describe '#match_time' do
      before :each do
        @rate = SpotHero::Rate.new(
        "days" => "sun,tues,thurs",
        "times" => "0900-2100",
        "price" => 1500
        )
      end
      it 'returns true if time and date specifications match' do
        expect(@rate.match_time?(
          DateTime.parse("2016-10-23T10:00:00Z"),
          DateTime.parse("2016-10-23T18:00:00Z")
        )).to be(true)
      end
      it 'returns false if time specifications do not match' do
        expect(@rate.match_time?(
        DateTime.parse("2016-10-23T08:00:00Z"),
        DateTime.parse("2016-10-23T18:00:00Z")
        )).to be(false)
      end
      it 'returns false if date specifications do not match' do
        expect(@rate.match_time?(
        DateTime.parse("2016-10-24T10:00:00Z"),
        DateTime.parse("2016-10-24T18:00:00Z")
        )).to be(false)
      end
      it 'returns properly on all edge cases' do
        expect(@rate.match_time?(
        DateTime.parse("2016-10-23T09:00:00Z"),
        DateTime.parse("2016-10-23T21:00:00Z")
        )).to be(true)
        expect(@rate.match_time?(
        DateTime.parse("2016-10-23T09:00:00Z"),
        DateTime.parse("2016-10-23T21:01:00Z")
        )).to be(false)
      end
    end
  end
end
