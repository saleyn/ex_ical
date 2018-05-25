defmodule ExIcalWeeklyTest do
  use ExUnit.Case
  alias ExIcal.DateParser

  doctest ExIcal

  test "weekly reccuring event with until" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    RRULE:FREQ=WEEKLY;UNTIL=20160201T083000Z
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
    assert event.start == DateParser.parse("20151231T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160107T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160114T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160121T083000Z")
    [event] = events
    assert event.start == DateParser.parse("20160128T083000Z")
  end

  test "weekly reccuring event" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    RRULE:FREQ=WEEKLY
    DESCRIPTION:Let's go see Star Wars.
    DTEND:20151224T084500Z
    DTSTART:20151224T083000Z
    SUMMARY:Film with Amy and Adam
    END:VEVENT
    END:VCALENDAR
    """
    events = ExIcal.parse(ical) |> ExIcal.by_range(DateParser.parse("20151224T083000Z"), DateParser.parse("20160121T084500Z"))
    assert events |> Enum.count == 5

    [event|events] = events
    assert event.start == DateParser.parse("20151224T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20151231T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160107T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160114T083000Z")
    [event] = events
    assert event.start == DateParser.parse("20160121T083000Z")
  end

  test "weekly reccuring event with until and interval" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    RRULE:FREQ=WEEKLY;UNTIL=20161224T083000Z;INTERVAL=8
    DESCRIPTION:Let's go see Star Wars.
    DTEND:20151224T084500Z
    DTSTART:20151224T083000Z
    SUMMARY:Film with Amy and Adam
    END:VEVENT
    END:VCALENDAR
    """
    events = ExIcal.parse(ical) |> ExIcal.by_range(DateParser.parse("20151224T083000Z"), DateParser.parse("20161224T084500Z"))
    assert events |> Enum.count == 7

    [event|events] = events
    assert event.start == DateParser.parse("20151224T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160218T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160414T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160609T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160804T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160929T083000Z")
    [event] = events
    assert event.start == DateParser.parse("20161124T083000Z")
  end


  test "weekly reccuring event with count" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    RRULE:FREQ=WEEKLY;COUNT=5
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
    assert event.start == DateParser.parse("20151231T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160107T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160114T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160121T083000Z")
    [event] = events
    assert event.start == DateParser.parse("20160128T083000Z")
  end

  test "weekly reccuring event with count and interval" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    RRULE:FREQ=WEEKLY;COUNT=4;INTERVAL=8
    DESCRIPTION:Let's go see Star Wars.
    DTEND:20151224T084500Z
    DTSTART:20151224T083000Z
    SUMMARY:Film with Amy and Adam
    END:VEVENT
    END:VCALENDAR
    """
    events = ExIcal.parse(ical) |> ExIcal.by_range(DateParser.parse("20151224T083000Z"), DateParser.parse("20161224T084500Z"))
    assert events |> Enum.count == 5

    [event|events] = events
    assert event.start == DateParser.parse("20151224T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160218T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160414T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160609T083000Z")
    [event] = events
    assert event.start == DateParser.parse("20160804T083000Z")
  end

  test "weekly reccuring event with interval" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    RRULE:FREQ=WEEKLY;INTERVAL=8
    DESCRIPTION:Let's go see Star Wars.
    DTEND:20151224T084500Z
    DTSTART:20151224T083000Z
    SUMMARY:Film with Amy and Adam
    END:VEVENT
    END:VCALENDAR
    """
    events = ExIcal.parse(ical) |> ExIcal.by_range(DateParser.parse("20151224T083000Z"), DateParser.parse("20161224T084500Z"))
    assert events |> Enum.count == 7

    [event|events] = events
    assert event.start == DateParser.parse("20151224T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160218T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160414T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160609T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160804T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160929T083000Z")
    [event] = events
    assert event.start == DateParser.parse("20161124T083000Z")
  end
end
