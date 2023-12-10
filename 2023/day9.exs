defmodule Part1 do
  defp get_stack(num_list, cur_stack) do
    diffs =
      num_list
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [first, second] -> second - first end)

    done = Enum.all?(diffs, fn diff -> diff == 0 end)

    case done do
      true -> [diffs | cur_stack]
      false -> get_stack(diffs, [diffs | cur_stack])
    end
  end

  def get_stack(num_list) do
    get_stack(num_list, [num_list])
  end

  defp extrapolate([], diff) do
    diff
  end

  defp extrapolate(num_stack, diff) do
    [next_layer | rest_stack] = num_stack
    direction = :prev

    next_diff =
      case direction do
        :next -> next_layer |> Enum.reverse() |> hd()
        :prev -> next_layer |> hd()
      end

    next_diff =
      case direction do
        :next -> next_diff + diff
        :prev -> next_diff - diff
      end

    extrapolate(rest_stack, next_diff)
  end

  def extrapolate(num_stack) do
    extrapolate(num_stack, 0)
  end
end

{:ok, text} = File.read("input/day9.txt")

text
|> String.split("\n", trim: true)
|> Enum.map(fn numstrs ->
  String.split(numstrs, " ", trim: true)
  |> Enum.map(fn num -> String.to_integer(num) end)
end)
|> Enum.map(fn nums -> Part1.get_stack(nums) end)
|> Enum.map(fn stack -> Part1.extrapolate(stack) end)
|> IO.inspect()
|> Enum.sum()
|> IO.inspect()
