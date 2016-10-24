module SpotHero
  class LotRateError < StandardError; end
  class DateError < LotRateError; end
  class TimeError < LotRateError; end
  class FileError < LotRateError; end
end
