defmodule ExIcal.DateParserTest do
  use ExUnit.Case
  import ExIcal.Test.Utils
  alias ExIcal.DateParser

  doctest DateParser

  date_match       = %{year: 1969, month: 6, day: 20}
  datetime_match   = %{year: 1969, month: 6, day: 20,
                       hour: 20, minute: 18, second: 4}
  chicago_match    = %{year: 1969, month: 6, day: 20,
                       hour: 15, minute: 18, second: 4}
  chicago_tzmatch  = "America/Chicago"
  berlin_tzmatch   = "Europe/Berlin"
  utc_tzmatch      = "UTC"

  allowed_date_formats = [
    #------------------+--------------------------------------------------+
    # Input Datestring |   Parsed Date |  Timezone When Global TZID = ?   |
    #                  |               |           nil |  America/Chicago |
    #------------------+--------------------------------------------------+
    {        "19690620",     date_match,  utc_tzmatch,  chicago_tzmatch,},
    {       "19690620Z",     date_match,  utc_tzmatch,      utc_tzmatch,},
    { "19690620T201804", datetime_match,  utc_tzmatch,  chicago_tzmatch,},
    {"19690620T201804Z", datetime_match,  utc_tzmatch,      utc_tzmatch,},
  ]
  for {input, date_match, no_tzid, global_tzid} <- allowed_date_formats do
    @tag input:    input
    @tag expected: %{date: date_match, timezone: no_tzid}
    test ~s[DateParser.parse/1 (date format: "#{input}")],
         %{input: input, expected: expected} do
      parsed_date = DateParser.parse input

      assert_subset expected.date, parsed_date
      assert_subset expected.timezone, parsed_date.time_zone
    end

    @tag input:    input
    @tag expected: %{date: date_match, timezone: no_tzid}
    test ~s[DateParser.parse/2 (timezone: nil, date format: "#{input}")],
         %{input: input, expected: expected} do
      parsed_date = DateParser.parse(input, nil)

      assert_subset expected.date, parsed_date
      assert_subset expected.timezone, parsed_date.time_zone
    end

    @tag input:    input
    @tag tzid:     tzid = "America/Chicago"
    @tag expected: %{date: date_match, timezone: global_tzid}
    test ~s[DateParser.parse/2 (timezone: "#{tzid}", date format: "#{input}")],
         %{input: input, expected: expected, tzid: tzid} do
      parsed_date = DateParser.parse(input, tzid)

      assert_subset expected.date, parsed_date
      assert_subset expected.timezone, parsed_date.time_zone
    end
  end

  allowed_date_formats = [
    #------------------+----------------------------------------------------------------+
    # Input Datestring |   Parsed Date |  Timezone When Global TZID = ?   |   Locale TZ |
    #                  |               |           nil |  America/Chicago |             |
    #------------------+----------------------------------------------------------------+
    {        "19690620",     date_match,  utc_tzmatch,  berlin_tzmatch,  chicago_tzmatch},
    {       "19690620Z",     date_match,  utc_tzmatch,      utc_tzmatch, chicago_tzmatch},
    { "19690620T201804", datetime_match,  utc_tzmatch,  berlin_tzmatch,  chicago_tzmatch},
    {"19690620T201804Z",  chicago_match,  utc_tzmatch,      utc_tzmatch, chicago_tzmatch},
  ]

  for {input, date_match, _no_tzid, global_tzid, locale_tzid} <- allowed_date_formats do
    @tag input:       input
    @tag tzid:        global_tzid
    @tag locale_tzid: locale_tzid
    @tag expected:    %{date: date_match, timezone: chicago_tzmatch}
    test ~s[DateParser.parse/2 locale #{locale_tzid} trumps everything else for input #{input}],
      %{input: input, expected: expected, tzid: tzid} do
      parsed_date = DateParser.parse(input, tzid, expected.timezone)

      assert_subset expected.date, parsed_date
      assert_subset expected.timezone, parsed_date.time_zone
    end
  end
end
