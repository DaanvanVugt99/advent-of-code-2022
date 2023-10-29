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
    |> Enum.reduce(stacks, &parse_move/2)
    |> Enum.map(&hd/1)
    |> Enum.join("")
  end

  def parse_move(move, stacks) do
    [n, origin, destination] =
      move
      |> String.split(~r/\s+/)
      |> Enum.reject(fn x -> Enum.member?(["move", "from", "to"], x) end)
      |> Enum.map(&String.to_integer/1)

    Enum.reduce(1..n, stacks, fn _, stacks -> move(stacks, origin - 1, destination - 1) end)
  end

  def move(stacks, origin, destination) do
    origin_stack = stacks |> Enum.fetch!(origin)
    destination_stack = stacks |> Enum.fetch!(destination)
    crate = hd(origin_stack)

    stacks
    |> List.replace_at(origin, Enum.drop(origin_stack, 1))
    |> List.replace_at(destination, [crate | destination_stack])
  end
end

{:ok, input} = File.read("inputs/advent5input.txt")
result = AdventFive.operate_crane(input)

IO.puts(result)
