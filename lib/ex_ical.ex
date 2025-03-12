defmodule ExIcal do
  @moduledoc """
  iCalendar parser for [Elixir](http://elixir-lang.org).

  ## Installation

  Add ex_ical to your list of dependencies in `mix.exs`:

  ```elixir
    def deps do
      [{:ex_ical, "~> 0.0.4"}]
    end
  ```

  ## Usage

  ```elixir
    HTTPotion.get("url-for-icalendar").body
      |> ExIcal.parse
      |> ExIcal.by_range(DateTime.utc_now(), DateTime.utc_now() |> Timex.shift(days: 7))
  ```
  """

  alias ExIcal.{Parser,Recurrence,Utils,Event}

  @spec parse(String.t, String.t|nil) :: [%Event{}]
  defdelegate parse(data, locale \\ nil), to: Parser

  @spec add_recurring_events([%Event{}]) :: [%Event{}]
  defdelegate add_recurring_events(events), to: Recurrence

  @spec add_recurring_events([%Event{}], %DateTime{}) :: [%Event{}]
  defdelegate add_recurring_events(events, end_date), to: Recurrence

  @spec sort_by_date([%Event{}]) :: [%Event{}]
  defdelegate sort_by_date(events), to: Utils

  @spec by_range([%Event{}], %DateTime{}, %DateTime{}) :: [%Event{}]
  defdelegate by_range(events, start_date, end_date), to: Utils
end
