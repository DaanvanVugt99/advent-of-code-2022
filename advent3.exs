defmodule AdventThree do
  # def solve(input) do
  #   input
  #   |> String.split("\n", trim: true)
  #   |> Enum.map(&priority/1)
  #   |> Enum.sum()
  # end

  # defp priority(line) do
  #   half = (String.length(line) / 2) |> trunc()

  #   rucksack_1 = String.slice(line, 0, half) |> String.to_charlist() |> MapSet.new()
  #   rucksack_2 = String.slice(line, half, half) |> String.to_charlist() |> MapSet.new()

  #   char = MapSet.intersection(rucksack_1, rucksack_2) |> MapSet.to_list() |> hd

  #   priorities = Enum.to_list(hd(~c"a")..hd(~c"z")) ++ Enum.to_list(hd(~c"A")..hd(~c"Z"))
  #   Enum.find_index(priorities, fn c -> c == char end) + 1
  # end

  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.chunk_every(3)
    |> Enum.map(&priority/1)
    |> Enum.sum()
  end

  defp priority(elves) do
    sets =
      Enum.map(elves, fn elf ->
        String.to_charlist(elf) |> MapSet.new()
      end)

    char =
      Enum.reduce(tl(sets), hd(sets), &MapSet.intersection/2)
      |> MapSet.to_list()
      |> hd

    priorities = Enum.to_list(hd(~c"a")..hd(~c"z")) ++ Enum.to_list(hd(~c"A")..hd(~c"Z"))
    Enum.find_index(priorities, fn c -> c == char end) + 1
  end
end

{:ok, input} = File.read("inputs/advent3input.txt")
IO.puts(AdventThree.solve(input))
