defmodule ExIcalMonthlyTest do
  use ExUnit.Case
  alias ExIcal.DateParser

  doctest ExIcal

  test "monthly reccuring event with until" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    RRULE:FREQ=MONTHLY;UNTIL=20161224T083000Z
    DESCRIPTION:Let's go see Star Wars.
    DTEND:20151224T084500Z
    DTSTART:20151224T083000Z
    SUMMARY:Film with Amy and Adam
    END:VEVENT
    END:VCALENDAR
    """
    events = ExIcal.parse(ical) |> ExIcal.by_range(DateParser.parse("20151224T083000Z"), DateParser.parse("20161224T084500Z"))
    assert events |> Enum.count == 13

    [event|events] = events
    assert event.start == DateParser.parse("20151224T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160124T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160224T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160324T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160424T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160524T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160624T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160724T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160824T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160924T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20161024T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20161124T083000Z")
    [event] = events
    assert event.start == DateParser.parse("20161224T083000Z")
  end

  test "monthly reccuring event" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    RRULE:FREQ=MONTHLY
    DESCRIPTION:Let's go see Star Wars.
    DTEND:20151224T084500Z
    DTSTART:20151224T083000Z
    SUMMARY:Film with Amy and Adam
    END:VEVENT
    END:VCALENDAR
    """
    events = ExIcal.parse(ical) |> ExIcal.by_range(DateParser.parse("20151224T083000Z"), DateParser.parse("20160924T084500Z"))
    assert events |> Enum.count == 10

    [event|events] = events
    assert event.start == DateParser.parse("20151224T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160124T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160224T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160324T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160424T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160524T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160624T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160724T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160824T083000Z")
    [event] = events
    assert event.start == DateParser.parse("20160924T083000Z")
  end

  test "monthly reccuring event with until and interval" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    RRULE:FREQ=MONTHLY;UNTIL=20161224T083000Z;INTERVAL=3
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
    assert event.start == DateParser.parse("20160324T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160624T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160924T083000Z")
    [event] = events
    assert event.start == DateParser.parse("20161224T083000Z")
  end

  test "monthly reccuring event with count" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    RRULE:FREQ=MONTHLY;COUNT=5
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
    assert event.start == DateParser.parse("20160124T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160224T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160324T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160424T083000Z")
    [event] = events
    assert event.start == DateParser.parse("20160524T083000Z")
  end

  test "monthly reccuring event with count and interval" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    RRULE:FREQ=MONTHLY;COUNT=5;INTERVAL=2
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
    assert event.start == DateParser.parse("20160224T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160424T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160624T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160824T083000Z")
    [event] = events
    assert event.start == DateParser.parse("20161024T083000Z")
  end

  test "monthly reccuring event with interval" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    RRULE:FREQ=MONTHLY;INTERVAL=2
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
    assert event.start == DateParser.parse("20160224T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160424T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160624T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20160824T083000Z")
    [event|events] = events
    assert event.start == DateParser.parse("20161024T083000Z")
    [event] = events
    assert event.start == DateParser.parse("20161224T083000Z")
  end
end
