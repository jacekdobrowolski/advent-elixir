defmodule Solution do
end

defmodule Solution.CLI do
  def main(_ \\ []) do
    {:ok, content} = File.read("input.txt")
    # content = "aonetreb7uchet"

    content
    |> String.trim()
    |> String.split()
    |> Enum.map(&get_first_and_last(&1))
    |> Enum.sum()
    |> dbg()
    |> IO.puts()

    #  content
    #  |> get_first_and_last()
    #  |> IO.puts()
  end

  def get_number(line) do
    line
    |> String.split(~r/[^0-9]/, trim: true)
    |> Enum.join()
    |> to_charlist()
  end

  def substitute(""), do: ""
  def substitute("one" <> tail), do: "1" <> substitute("ne" <> tail)
  def substitute("two" <> tail), do: "2" <> substitute("wo" <> tail)
  def substitute("three" <> tail), do: "3" <> substitute("hree" <> tail)
  def substitute("four" <> tail), do: "4" <> substitute("our" <> tail)
  def substitute("five" <> tail), do: "5" <> substitute("ive" <> tail)
  def substitute("six" <> tail), do: "6" <> substitute("ix" <> tail)
  def substitute("seven" <> tail), do: "7" <> substitute("even" <> tail)
  def substitute("eight" <> tail), do: "8" <> substitute("ight" <> tail)
  def substitute("nine" <> tail), do: "9" <> substitute("ine" <> tail)

  def substitute(tail) do
    [head | tail] = to_charlist(tail)
    to_string([head]) <> substitute(to_string(tail))
  end

  def get_first_and_last(line) do
    numbers =
      line
      |> substitute()
      |> get_number()

    first_and_last =
      numbers
      |> Enum.map(&to_string(&1 - 48))

    (List.first(first_and_last) <> List.last(first_and_last))
    |> String.to_integer()
  end
end
