Mix.install([:jason, :benchee])

defmodule ListInsertion do
  def insert_band(band) do
    bands_list = File.read!("bands.json") |> Jason.decode!()
    List.insert_at(bands_list, 0, band)
  end
end

defmodule MapSetInsertion do
  def insert_band(band) do
    bands_set = File.read!("bands.json") |> Jason.decode!() |> MapSet.new()
    MapSet.put(bands_set, band)
  end
end

Benchee.run(
  %{
    "list" => fn ->
      _result = ListInsertion.insert_band("New Band")
    end,
    "MapSet" => fn ->
      _result = MapSetInsertion.insert_band("New Band")
    end
  },
  time: 10,
  memory_time: 2
)
