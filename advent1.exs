defmodule AdventOne do
  def find_most_calories(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&sum_calories/1)
    |> Enum.max()
  end

  def find_top_three_calories(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&sum_calories/1)
    |> Enum.sort()
    |> Enum.take(-3)
    |> Enum.sum()
  end

  defp sum_calories(group) do
    group
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end
end

{:ok, input} = File.read("inputs/advent1input.txt")
result1 = AdventOne.find_most_calories(input)
result2 = AdventOne.find_top_three_calories(input)
IO.puts("Total for elf with most calories: #{result1}")
IO.puts("Total for top three elves with most calories: #{result2}")
