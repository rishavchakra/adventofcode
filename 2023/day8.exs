require Math

defmodule Part1 do
  defp search(_, <<_, _, ?Z>>, pathlen, _, _) do
    pathlen
  end

  defp search(map, node, pathlen, cur_dirs, dirs) do
    {cur_dir, rest_dirs} =
      case cur_dirs do
        [h | t] -> {h, t}
        [] -> {hd(dirs), tl(dirs)}
      end

    # IO.inspect({node, Map.get(map, node)})

    next_node =
      case cur_dir do
        "R" -> Map.get(map, node) |> elem(1)
        "L" -> Map.get(map, node) |> elem(0)
      end

    search(map, next_node, pathlen + 1, rest_dirs, dirs)
  end

  def search(map, source, directions) do
    search(map, source, 0, directions, directions)
  end
end

{:ok, text} = File.read("input/day8.txt")

lines =
  text
  |> String.split("\n", trim: true)

directions = hd(lines) |> String.split("", trim: true) |> IO.inspect()

map =
  lines
  |> tl()
  |> Enum.map(fn line ->
    src = String.slice(line, 0..2)
    left = String.slice(line, 7..9)
    right = String.slice(line, 12..14)
    {src, left, right}
  end)
  |> Enum.reduce(Map.new(), fn {src, left, right}, map ->
    Map.put(map, src, {left, right})
  end)
  |> IO.inspect()

# Part 1
map
|> Part1.search("AAA", directions)
|> IO.inspect()

# Part 2
lines
|> tl()
|> Enum.map(fn line ->
  String.slice(line, 0..2)
end)
|> Enum.filter(fn source -> String.ends_with?(source, "A") end)
|> IO.inspect()
|> Enum.map(fn source -> Part1.search(map, source, directions) end)
|> Enum.reduce(1, fn num, lcm ->
  Math.lcm(num, lcm)
end)
|> IO.inspect()
