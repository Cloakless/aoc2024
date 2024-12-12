data = [[67, 69, 70, 71, 72, 75, 74], [...], [67, 68, 70, 71, 74, 76]]

# Then do things

defmodule Data do
  def is_safe(nums) do
    case nums do
      [] -> true
      [_] -> true
      [x | tail] -> check_strict(tail, x, nil)
    end
  end

  def is_mostly_safe([]), do: true
  def is_mostly_safe([_]), do: true
  def is_mostly_safe(nums) do
    Enum.with_index(nums)
    |> Enum.any?(fn {_, idx} ->
      {head, [_ | tail]} = Enum.split(nums, idx)
      case head ++ tail do
        [] -> true
        [_] -> true
        [x | rest] -> check_strict(rest, x, nil)
      end
    end)
  end

  defp check_strict([], prev, dir), do: true
  defp check_strict([x | tail], prev, nil) do
    diff = prev - x
    if abs(diff) in 1..3 do
      if diff > 0 do
        check_strict(tail, x, :-)
      else
        check_strict(tail, x, :+)
      end
    else
      false
    end
  end

  defp check_strict([x | tail], prev, dir) do
    diff = prev - x
    if abs(diff) in 1..3 and ((dir == :+ and diff < 0) or (dir == :- and diff > 0)) do
      check_strict(tail, x, dir)
    else
      false
    end
  end
end


ans1 = List.foldr(data, 0, fn(x, acc) -> if Data.is_safe(x) do acc + 1 else acc end end)
IO.puts(ans1)

ans2 = List.foldr(data, 0, fn(x, acc) -> if Data.is_mostly_safe(x) do acc + 1 else acc end end)
IO.puts(ans2)
