{:ok, text} = File.read("input/day2.txt")

text
|> String.split("\n", trim: true)
|> Enum.map(fn line -> String.trim_leading(line, "Game ") end)
|> Enum.map(fn line ->
  [num | rest] = String.split(line, ":")
  [groups | _] = rest
  {String.to_integer(num), groups}
end)
|> Enum.map(fn {i, line} ->
  line_res =
    String.split(line, ";")
    |> Enum.reduce({0, 0, 0}, fn group, {r, g, b} ->
      {group_r, group_g, group_b} =
        group
        |> String.trim()
        |> String.split(",")
        |> Enum.reduce({0, 0, 0}, fn item, {r1, g1, b1} ->
          num =
            item
            |> String.trim()
            |> String.replace(~r/ \w+/, "")
            |> String.to_integer()

          cond do
            String.ends_with?(item, "red") -> {r1 + num, g1, b1}
            String.ends_with?(item, "green") -> {r1, g1 + num, b1}
            String.ends_with?(item, "blue") -> {r1, g1, b1 + num}
          end
        end)

      {max(group_r, r), max(group_g, g), max(group_b, b)}
    end)

  {i, line_res}
end)
# Part 1
# |> Enum.filter(fn {_, {r, g, b}} -> r <= 12 and g <= 13 and b <= 14 end)
# |> Enum.reduce(0, fn {i, _}, acc -> i + acc end)

# Part 2
|> Enum.map(fn {_, {r, g, b}} -> r * g * b end)
|> Enum.sum()
|> IO.puts()
