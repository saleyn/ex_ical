defmodule ExIcalTzidTest do
  use ExUnit.Case
  alias ExIcal.DateParser

  test "daily reccuring event with until and tzid" do
    tzid = "Europe/Berlin"
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    TZID:#{tzid}
    BEGIN:VEVENT
    RRULE:FREQ=DAILY;UNTIL=20151231T083000
    DESCRIPTION:Let's go see Star Wars.
    DTEND:20151224T084500
    DTSTART:20151224T083000
    SUMMARY:Film with Amy and Adam
    END:VEVENT
    END:VCALENDAR
    """
    events = ical
             |> ExIcal.parse
             |> ExIcal.by_range(DateParser.parse("20151224T083000", tzid),
                                DateParser.parse("20161224T084500", tzid))
    expected_starts = ~w[
      20151224T083000 20151225T083000 20151226T083000 20151227T083000
      20151228T083000 20151229T083000 20151230T083000 20151231T083000
    ]

    assert events |> Enum.count == 8
    for {event, expected_start} <- Enum.zip(events, expected_starts) do
      assert event.start == DateParser.parse(expected_start, tzid)
    end
  end
end
