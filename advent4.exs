defmodule Range do
  def from_string(str) do
    [start_str, stop_str] = String.split(str, "-", parts: 2)
    {String.to_integer(start_str), String.to_integer(stop_str)}
  end

  def contains?(range1, range2) do
    {start1, stop1} = range1
    {start2, stop2} = range2
    start1 <= start2 && stop1 >= stop2
  end
end

defmodule SectionAssignment do
  def contains(range1_str, range2_str) do
    range1 = Range.from_string(range1_str)
    range2 = Range.from_string(range2_str)

    if Range.contains?(range1, range2) do
      IO.puts("#{range1_str}, #{range2_str} contains")
      true
    else
      if Range.contains?(range2, range1) do
        IO.puts("#{range1_str}, #{range2_str} is contained by")
        true
      else
        false
      end
    end
  end
end

defmodule AdventFour do
  def count_containment(pairs) do
    Enum.reduce(pairs, 0, fn pair, count ->
      [range1_str, range2_str] = String.split(pair, ",")

      if SectionAssignment.contains(range1_str, range2_str) do
        count + 1
      else
        count
      end
    end)
  end

  def get_containing_pairs(input) do
    pairs = String.split(input, "\n", trim: true)
    result = count_containment(pairs)
    IO.puts("Number of assignment pairs that contain one another: #{result}")
  end
end

{:ok, input} = File.read("inputs/advent4input.txt")
AdventFour.get_containing_pairs(input)
