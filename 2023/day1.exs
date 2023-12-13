defmodule Parse do
  defp parse_line("", cur_nums) do
    cur_nums
  end

  defp parse_line(line, cur_nums) do
    {_, rest_line} = String.next_grapheme(line)

    new_nums = cond do
      String.starts_with?(line, "1") -> [1 | cur_nums]
      String.starts_with?(line, "2") -> [2 | cur_nums]
      String.starts_with?(line, "3") -> [3 | cur_nums]
      String.starts_with?(line, "4") -> [4 | cur_nums]
      String.starts_with?(line, "5") -> [5 | cur_nums]
      String.starts_with?(line, "6") -> [6 | cur_nums]
      String.starts_with?(line, "7") -> [7 | cur_nums]
      String.starts_with?(line, "8") -> [8 | cur_nums]
      String.starts_with?(line, "9") -> [9 | cur_nums]
      String.starts_with?(line, "0") -> [0 | cur_nums]
      String.starts_with?(line, "1") -> [1 | cur_nums]

      # Part 2
      String.starts_with?(line, "one") -> [1 | cur_nums]
      String.starts_with?(line, "two") -> [2 | cur_nums]
      String.starts_with?(line, "three") -> [3 | cur_nums]
      String.starts_with?(line, "four") -> [4 | cur_nums]
      String.starts_with?(line, "five") -> [5 | cur_nums]
      String.starts_with?(line, "six") -> [6 | cur_nums]
      String.starts_with?(line, "seven") -> [7 | cur_nums]
      String.starts_with?(line, "eight") -> [8 | cur_nums]
      String.starts_with?(line, "nine") -> [9 | cur_nums]
      true -> cur_nums
    end

    parse_line(rest_line, new_nums)
  end

  def parse_line(line) do
    parse_line(line, [])
  end
end

{:ok, text} = File.read("input/day1.txt")

text
|> String.split("\n", trim: true)
|> Enum.map(fn line -> Parse.parse_line(line) end)
|> Enum.map(fn num_list ->
  last = hd(num_list)
  first = num_list |> Enum.reverse() |> hd()
  {first, last}
end)
|> Enum.map(fn {tens, ones} ->
  tens * 10 + ones
end)
|> IO.inspect()
|> Enum.sum()
|> IO.inspect()
