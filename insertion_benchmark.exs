Mix.install([:jason, :benchee])

defmodule ListInsertion do
  @bands_list File.read!("bands.json") |> Jason.decode!()

  def insert_band_first() do
    Enum.reduce(1..500, @bands_list, fn band, acc ->
      ["band-#{band}" | acc]
    end)
  end

  def insert_band_last() do
    Enum.reduce(1..500, @bands_list, fn band, acc ->
      acc ++ ["band-#{band}"]
    end)
  end
end

defmodule MapSetInsertion do
  @bands_set File.read!("bands.json") |> Jason.decode!() |> MapSet.new()

  def insert_band() do
    Enum.reduce(1..500, @bands_set, fn band, acc ->
      MapSet.put(acc, "band-#{band}")
    end)
  end
end

Benchee.run(
  %{
    "list first" => fn ->
      _result = ListInsertion.insert_band_first()
    end,
    "list last" => fn ->
      _result = ListInsertion.insert_band_last()
    end,
    "MapSet" => fn ->
      _result = MapSetInsertion.insert_band()
    end
  },
  time: 10,
  memory_time: 2
)
