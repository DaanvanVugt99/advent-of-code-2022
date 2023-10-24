defmodule AdventTwo do
  # First half

  @scores %{
    {"A", "X"} => 3, {"A", "Y"} => 6, {"A", "Z"} => 0,
    {"B", "X"} => 0, {"B", "Y"} => 3, {"B", "Z"} => 6,
    {"C", "X"} => 6, {"C", "Y"} => 0, {"C", "Z"} => 3
  }

  @bonus %{
    {"X"} => 1,
    {"Y"} => 2,
    {"Z"} => 3,
  }

  # calc total score
  def total_score(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&round_result/1)
    |> Enum.sum()
  end

  # get round score
  def round_result(round) do
    points_score(round) + points_bonus(round)
  end

  # get point score
  defp points_score(round) do
    case @scores[{String.at(round, 0), String.at(round, 2)}] do
      score when is_integer(score) -> score
      _ -> 0
    end
  end

  # get bonus score
  defp points_bonus(bonus) do
    case @bonus[{String.at(bonus, 2)}] do
      score when is_integer(score) -> score
      _ -> 0
    end
  end

  # Second half (bonus for combination always the same)

  @scores2 %{
    {"A", "X"} => 3, {"A", "Y"} => 4, {"A", "Z"} => 8,
    {"B", "X"} => 1, {"B", "Y"} => 5, {"B", "Z"} => 9,
    {"C", "X"} => 2, {"C", "Y"} => 6, {"C", "Z"} => 7
  }

  def total_score_two(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&round_result_two/1)
    |> Enum.sum()
  end

  defp round_result_two(round) do
    case @scores2[{String.at(round, 0), String.at(round, 2)}] do
      score when is_integer(score) -> score
      _ -> 0
    end
  end

end

{:ok, input} = File.read("inputs/advent2input.txt")

total_score = AdventTwo.total_score(input)
IO.puts("Total score according to strategy guide is: #{total_score}")

total_score_two = AdventTwo.total_score_two(input)
IO.puts("Total score according to strategy guide is: #{total_score_two}")
