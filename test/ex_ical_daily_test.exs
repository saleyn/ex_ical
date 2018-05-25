defmodule ExIcalDailyTest do
  use ExUnit.Case
  alias ExIcal.DateParser

  doctest ExIcal

  test "daily reccuring event with until" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    RRULE:FREQ=DAILY;UNTIL=20151231T083000Z
    DESCRIPTION:Let's go see Star Wars.
    DTEND:20151224T084500Z
    DTSTART:20151224T083000Z
    SUMMARY:Film with Amy and Adam
    END:VEVENT
    END:VCALENDAR
    """
    events = ExIcal.parse(ical) |> ExIcal.by_range(DateParser.parse("20151224T083000Z"), DateParser.parse("20161224T084500Z"))
    assert events |> Enum.count == 8

    [event|events] = events
    assert event.start == DateParser.parse("20151224T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151225T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151226T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151227T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151228T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151229T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151230T083000Z")
    [event] = events
    assert event.start == DateParser.parse("20151231T083000Z")
  end

  test "daily reccuring event" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    RRULE:FREQ=DAILY
    DESCRIPTION:Let's go see Star Wars.
    DTEND:20151224T084500Z
    DTSTART:20151224T083000Z
    SUMMARY:Film with Amy and Adam
    END:VEVENT
    END:VCALENDAR
    """
    events = ExIcal.parse(ical) |> ExIcal.by_range(DateParser.parse("20151224T083000Z"), DateParser.parse("20151230T084500Z"))
    assert events |> Enum.count == 7

    [event|events] = events
    assert event.start == DateParser.parse("20151224T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151225T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151226T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151227T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151228T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151229T083000Z")
    [event] = events
    assert event.start == DateParser.parse("20151230T083000Z")
  end

  test "daily reccuring event with until and interval" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    RRULE:FREQ=DAILY;UNTIL=20151231T083000Z;INTERVAL=3
    DESCRIPTION:Let's go see Star Wars.
    DTEND:20151224T084500Z
    DTSTART:20151224T083000Z
    SUMMARY:Film with Amy and Adam
    END:VEVENT
    END:VCALENDAR
    """
    events = ExIcal.parse(ical) |> ExIcal.by_range(DateParser.parse("20151224T083000Z"), DateParser.parse("20161224T084500Z"))
    assert events |> Enum.count == 3

    [event|events] = events
    assert event.start == DateParser.parse("20151224T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151227T083000Z")
    [event] = events
    assert event.start == DateParser.parse("20151230T083000Z")
  end

  test "daily reccuring event with count" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    RRULE:FREQ=DAILY;COUNT=5
    DESCRIPTION:Let's go see Star Wars.
    DTEND:20151224T084500Z
    DTSTART:20151224T083000Z
    SUMMARY:Film with Amy and Adam
    END:VEVENT
    END:VCALENDAR
    """
    events = ExIcal.parse(ical) |> ExIcal.by_range(DateParser.parse("20151224T083000Z"), DateParser.parse("20161224T084500Z"))
    assert events |> Enum.count == 6

    [event|events] = events
    assert event.start == DateParser.parse("20151224T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151225T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151226T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151227T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151228T083000Z")
    [event] = events
    assert event.start == DateParser.parse("20151229T083000Z")
  end

  test "daily reccuring event with count and interval" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    RRULE:FREQ=DAILY;COUNT=5;INTERVAL=2
    DESCRIPTION:Let's go see Star Wars.
    DTEND:20151224T084500Z
    DTSTART:20151224T083000Z
    SUMMARY:Film with Amy and Adam
    END:VEVENT
    END:VCALENDAR
    """
    events = ExIcal.parse(ical) |> ExIcal.by_range(DateParser.parse("20151224T083000Z"), DateParser.parse("20161224T084500Z"))
    assert events |> Enum.count == 6

    [event|events] = events
    assert event.start == DateParser.parse("20151224T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151226T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151228T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151230T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160101T083000Z")
    [event] = events
    assert event.start == DateParser.parse("20160103T083000Z")
  end

  test "daily reccuring event with interval" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    RRULE:FREQ=DAILY;INTERVAL=2
    DESCRIPTION:Let's go see Star Wars.
    DTEND:20151224T084500Z
    DTSTART:20151224T083000Z
    SUMMARY:Film with Amy and Adam
    END:VEVENT
    END:VCALENDAR
    """
    events = ExIcal.parse(ical) |> ExIcal.by_range(DateParser.parse("20151224T083000Z"), DateParser.parse("20151231T084500Z"))
    assert events |> Enum.count == 4

    [event|events] = events
    assert event.start == DateParser.parse("20151224T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151226T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151228T083000Z")
    [event] = events
    assert event.start == DateParser.parse("20151230T083000Z")
  end
end
