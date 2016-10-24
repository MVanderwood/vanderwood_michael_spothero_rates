module SpotHero
  class Rate
    WEEKDAYS = ['sun', 'mon', 'tues', 'wed', 'thurs', 'fri', 'sat']

    attr_reader :days, :times, :price
    def initialize(args={})
      @days = args["days"].split(",")
      @times = hours_to_range(args["times"])
      @price = args["price"]
    end

    def match_time?(time_start, time_end)
      return false unless times.include?(get_minutes(time_start))
      return false unless times.include?(get_minutes(time_end))
      return false unless days.include?(WEEKDAYS[time_start.wday])
      return false unless days.include?(WEEKDAYS[time_end.wday])
      true
    end

    private

    def get_minutes(date_time)
      date_time.hour * 100 + date_time.minute
    end

    def hours_to_range(hours_string)
      arr = hours_string.split("-").map { |hour| hour.to_i }
      arr[0]..arr[1]
    end
  end
end

# RSpec.describe 'SpotHero' do
#   describe '::Rate' do
#     describe '#match_time' do
#       before :each do
#         @rate = SpotHero::Rate.new(
#         "days" => "sun,tues,thurs",
#         "times" => "0900-2100",
#         "price" => 1500
#         )
#       end
#       it 'returns true if time and date specifications match' do
#         expect(@rate.match_time?(
#           DateTime.parse("2016-10-23T10:00:00Z"),
#           DateTime.parse("2016-10-23T18:00:00Z")
#         )).to be(true)
#       end
#       it 'returns false if time specifications do not match' do
#         expect(@rate.match_time?(
#         DateTime.parse("2016-10-23T08:00:00Z"),
#         DateTime.parse("2016-10-23T18:00:00Z")
#         )).to be(false)
#       end
#       it 'returns false if date specifications do not match' do
#         expect(@rate.match_time?(
#         DateTime.parse("2016-10-24T10:00:00Z"),
#         DateTime.parse("2016-10-24T18:00:00Z")
#         )).to be(false)
#       end
#       it 'returns properly on all edge cases' do
#         expect(@rate.match_time?(
#         DateTime.parse("2016-10-23T09:00:00Z"),
#         DateTime.parse("2016-10-23T21:00:00Z")
#         )).to be(true)
#         expect(@rate.match_time?(
#         DateTime.parse("2016-10-23T09:00:00Z"),
#         DateTime.parse("2016-10-23T21:01:00Z")
#         )).to be(false)
#       end
#     end
#   end
# end
