defmodule DateTimeGenerator do
  import StreamData

  @time_zones ["Etc/UTC"]

  def date do
    tuple({integer(1970..2050), integer(1..12), integer(1..31)})
    |> bind_filter(fn tuple ->
      case Date.from_erl(tuple) do
        {:ok, date} -> {:cont, constant(date)}
        _ -> :skip
      end
    end)
  end

  def time do
    tuple({integer(0..23), integer(0..59), integer(0..59)})
    |> map(&Time.from_erl!/1)
  end

  def naive_datetime do
    tuple({date(), time()})
    |> map(fn {date, time} ->
      {:ok, naive_datetime} = NaiveDateTime.new(date, time)
      naive_datetime
    end)
  end

  def datetime do
    tuple({naive_datetime(), member_of(@time_zones)})
    |> map(fn {naive_datetime, time_zone} ->
      DateTime.from_naive!(naive_datetime, time_zone)
    end)
  end

  def between(%Date{} = from, %Date{} = to) do
    between(date_to_datetime(from), date_to_datetime(to))
  end

  def between(%NaiveDateTime{} = from, %NaiveDateTime{} = to) do
    between(naivedatetime_to_datetime(from), naivedatetime_to_datetime(to))
  end

  def between(from, to) do
    unix_between(to_timestamp(from), to_timestamp(to))
  end

  defp unix_between(from, to) do
    diff = to - from
    sign = if diff < 0, do: -1, else: 1

    date = from + sign * Enum.random(0..abs(diff))

    DateTime.from_unix!(date, :microsecond)
  end

  defp to_timestamp(datetime) do
    DateTime.to_unix(datetime, :microsecond)
  end

  defp date_to_datetime(date) do
    %DateTime{
      calendar: Calendar.ISO,
      day: date.day,
      hour: 0,
      minute: 0,
      month: date.month,
      second: 0,
      time_zone: "Etc/UTC",
      utc_offset: 0,
      std_offset: 0,
      year: date.year,
      zone_abbr: "UTC"
    }
  end

  defp naivedatetime_to_datetime(date_time) do
    %DateTime{
      calendar: date_time.calendar,
      day: date_time.day,
      hour: date_time.hour,
      minute: date_time.minute,
      month: date_time.month,
      second: date_time.second,
      time_zone: "Etc/UTC",
      utc_offset: 0,
      std_offset: 0,
      year: date_time.year,
      zone_abbr: "UTC"
    }
  end



end
