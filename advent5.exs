defmodule AdventFive do
  def get_stacks(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.take(8)
    |> Enum.join("\n")
  end

  def parse_stacks(stacks) do
    stacks
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_row/1)
    |> transpose_matrix()
    |> Enum.map(fn row -> Enum.filter(row, fn x -> x != "0" end) end)
  end

  def parse_row(row) do
    row
    |> String.replace("    ", " [0]")
    |> String.replace(~r/[\[\] ]/, "")
    |> String.graphemes()
  end

  def transpose_matrix(matrix) do
    for col <- 0..length(matrix) do
      for row <- matrix, do: Enum.at(row, col)
    end
  end

  def get_moves(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.take(
      -(input
        |> String.split("\n", trim: true)
        |> length()) + 9
    )
    |> Enum.join("\n")
  end

  def operate_crane(input) do
    stacks = parse_stacks(get_stacks(input))
    moves = get_moves(input)

    moves
    |> String.split("\n", trim: true)
    |> Enum.reduce(stacks, &parse_move_9001/2)
    |> Enum.map(&hd/1)
    |> Enum.join("")
  end

  # Part 1

  def parse_move_9000(move, stacks) do
    [n, origin, destination] =
      move
      |> String.split(~r/\s+/)
      |> Enum.reject(fn x -> Enum.member?(["move", "from", "to"], x) end)
      |> Enum.map(&String.to_integer/1)

    Enum.reduce(1..n, stacks, fn _, stacks -> move_9000(stacks, origin, destination) end)
  end

  def move_9000(stacks, origin, destination) do
    origin_stack = stacks |> Enum.fetch!(origin - 1)
    destination_stack = stacks |> Enum.fetch!(destination - 1)
    crate = hd(origin_stack)

    stacks
    |> List.replace_at(origin - 1, Enum.drop(origin_stack, 1))
    |> List.replace_at(destination - 1, [crate | destination_stack])
  end

  # Part 2

  def parse_move_9001(move, stacks) do
    [n, origin, destination] =
      move
      |> String.split(~r/\s+/)
      |> Enum.reject(fn x -> Enum.member?(["move", "from", "to"], x) end)
      |> Enum.map(&String.to_integer/1)

    origin_stack = stacks |> Enum.fetch!(origin - 1)
    replace_origin_stack = origin_stack |> Enum.slice(n, length(origin_stack) - n)
    destination_stack = stacks |> Enum.fetch!(destination - 1)

    crates = origin_stack |> Enum.slice(0..(n - 1))

    stacks
    |> List.replace_at(origin - 1, replace_origin_stack)
    |> List.replace_at(destination - 1, crates ++ destination_stack)
  end
end

{:ok, input} = File.read("inputs/advent5input.txt")
result = AdventFive.operate_crane(input)

IO.puts(result)
