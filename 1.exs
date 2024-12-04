list1 = [53906, 35867, [...] 28292, 14969]
list2 = [14872, 86182, [...] 57181, 84572]
pairs = Enum.zip([Enum.sort(list1), Enum.sort(list2)])

ans = List.foldr(pairs, 0, fn(x, acc) -> abs(elem(x, 0) - elem(x, 1)) + acc end)

IO.puts(ans)

freqs = Enum.frequencies(list2)
ans2 = List.foldr(list1, 0, fn(x, acc) -> (x * Map.get(freqs, x, 0)) + acc end)
IO.puts(ans2)
