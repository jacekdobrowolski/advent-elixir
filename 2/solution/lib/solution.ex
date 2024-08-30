defmodule Solution do
end

defmodule Solution.CLI do
  def main(_ \\ []) do
    {:ok, content} = File.read("input.txt")
    # content = """
    # Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    # Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    # Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    # Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    # Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    # """

    content
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&get_possible_game_id(&1))
    |> Enum.sum()
    |> IO.puts()

    #  content
    #  |> get_first_and_last()
    #  |> IO.puts()
  end

  def get_possible_game_id(line) do
    [game_with_id | sets] = String.split(line, ":", trim: true)

    "Game " <> id = game_with_id

    dbg()

    game_power(sets)
  end

  def game_power([sets]) do
    sets
    |> String.split(";", trim: true)
    |> Enum.map(&get_cube_count_map/1)
    |> Enum.reduce(
      &Map.merge(&1, &2, fn _key, value1, value2 ->
        max(value1, value2)
      end)
    )
    |> Map.values()
    |> Enum.reduce(&(&1 * &2))
  end

  def get_cube_count_map(set) do
    set
    |> to_string()
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&cube_map/1)
    |> Enum.reduce(&Map.merge/2)
  end

  def cube_map(cube) do
    [count | color] = String.split(cube)
    %{String.to_existing_atom(List.first(color)) => String.to_integer(count)}
  end

  def smaller_than?(map, in_the_bag \\ %{red: 12, green: 13, blue: 14}) do
    set_keys = Map.keys(map)
    keys_in_the_bag = MapSet.new(Map.keys(in_the_bag))

    Enum.all?(set_keys, fn color_key ->
      MapSet.member?(keys_in_the_bag, color_key) and
        map[color_key] <= in_the_bag[color_key]
    end)
  end
end
