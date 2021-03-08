defmodule ListFilter do
  require Integer

  def call(list) do
    numbers_list = filter(list, :only_numbers)

    list
    |> filter(:only_strings)
    |> filter(numbers_list)
    |> filter(:only_odd)
    |> length()
  end

  defp filter(list, :only_numbers) do
    Enum.filter(list, fn elem -> is_number(elem) end)
  end

  defp filter(list, :only_strings) do
    Enum.filter(list, fn elem -> is_binary(elem) end)
  end

  defp filter(list, :only_odd) do
    Enum.filter(list, fn elem ->
      Integer.is_odd(elem)
    end)
  end

  defp filter(list, numbers_list) do
    Enum.flat_map(list, fn elem ->
      case Integer.parse(elem) do
        {int, _rest} -> numbers_list ++ [int]
        :error -> []
      end
    end)
  end
end
