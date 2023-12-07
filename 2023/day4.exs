{:ok, text} = File.read("input/day4.txt")

text
|> String.split("\n", trim: true)
|> Enum.map(fn line -> String.replace(line, ~r/Card\W+\d+: /, "") end)
|> Enum.map(fn line -> String.split(line, " | ") end)
|> Enum.map(fn [winning, mine] ->
  set =
    winning
    |> String.split()
    |> Enum.filter(fn num -> num != "" end)
    |> Enum.map(fn num_str -> String.to_integer(num_str) end)
    |> MapSet.new()

  {set, mine}
end)
|> Enum.map(fn {set, mine} ->
  nums =
    mine
    |> String.split()
    |> Enum.filter(fn num -> num != "" end)
    |> Enum.map(fn num_str -> String.to_integer(num_str) end)

  {set, nums}
end)
# Part 1
# |> Enum.map(fn {set, mine} ->
# |> Enum.reduce(0, fn num, val ->
#   cond do
#     MapSet.member?(set, num) ->
#       case val do
#         0 -> 1
#         x -> x * 2
#       end

#     true ->
#       val
#   end
# end)
# end)
# |> Enum.sum()
# End Part 1

# Part 2
|> Enum.reduce({0, [0]}, fn {set, nums}, {num_cards, card_copies} ->
  {mult, rest_copies} =
    case card_copies do
      [this_card_copies | rest] -> {this_card_copies + 1, rest}
      _ -> {1, []}
    end

  copies =
    Enum.reduce(nums, {rest_copies, []}, fn num, {copies, copies_acc} ->
      {hd_copies, tl_copies} =
        case copies do
          [h | t] -> {h, t}
          _ -> {0, []}
        end

      cond do
        MapSet.member?(set, num) ->
          {tl_copies, [hd_copies + mult | copies_acc]}

        true ->
          {copies, copies_acc}
      end
    end)

  copies =
    [Enum.reverse(elem(copies, 1)), elem(copies, 0)]
    |> Enum.concat()

  {num_cards + mult, copies}
end)
|> elem(0)
# End Part 2
|> IO.inspect()
