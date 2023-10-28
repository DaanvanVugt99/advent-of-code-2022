defmodule AdventFour do
  def get_breakpoints(row) do
    [range1_str, range2_str] = String.split(row, ",")
    [start_str1, stop_str1] = String.split(range1_str, "-")
    [start_str2, stop_str2] = String.split(range2_str, "-")

    {String.to_integer(start_str1), String.to_integer(stop_str1), String.to_integer(start_str2),
     String.to_integer(stop_str2)}
  end

  def contains?(row) do
    {start1, stop1, start2, stop2} = AdventFour.get_breakpoints(row)
    (start1 <= start2 && stop1 >= stop2) || (start1 >= start2 && stop1 <= stop2)
  end

  def overlaps?(row) do
    {start1, stop1, start2, stop2} = AdventFour.get_breakpoints(row)
    start1 <= stop2 && start2 <= stop1
  end

  def get_pairs_containing(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&contains?/1)
    |> length
  end

  def get_pairs_overlapping(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&overlaps?/1)
    |> length
  end
end

{:ok, input} = File.read("inputs/advent4input.txt")
result1 = AdventFour.get_pairs_containing(input)
IO.puts("total containing: #{result1}")
result2 = AdventFour.get_pairs_overlapping(input)
IO.puts("total containing: #{result2}")
