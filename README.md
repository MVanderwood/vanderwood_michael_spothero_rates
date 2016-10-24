# VanderwoodMichaelSpotheroRates

## Instructions

1. Unpack file
2. Run application:
  ```
    ruby spothero_rates <json_lot_data_file> <start_time> <end_time>
  ```
  ex:
  ```
    ruby spothero_rates spec/test_data.json 2016-10-23T10:00:00Z 2016-10-23T11:00:00Z
  ```
3. Run tests:
  ```
    rspec spec/run_specs
  ```

## Dependencies
- [RSpec](https://github.com/rspec/rspec)
- Installation: `gem install rspec`
