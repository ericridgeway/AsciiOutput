defmodule AsciiOutput.FromAsciiInput do
  @type ascii_input :: [row]
  @type row :: [key]
  @type key :: String.t
  @type translater :: %{key => any}


  @spec generate_map(ascii_input, translater) :: Main.input_map
  def generate_map(ascii_input, translater) do
    add_index_and_reduce(ascii_input, Map.new, &row_from_ascii(&1, &2, translater))
  end


  defp row_from_ascii({row, row_num}, new_map, translater) do
    add_index_and_reduce(row, new_map, &col_from_ascii(&1, &2, row_num, translater))
  end

  defp col_from_ascii({".", _}, new_map, _, _), do: new_map
  defp col_from_ascii({col, col_num}, new_map, row_num, translater) do
    lookup_translation(translater, col)
    |> add_val_to_map(new_map, {col_num, row_num})
  end

  defp lookup_translation(translater, value), do: Map.get(translater, value, value)
  defp add_val_to_map(val, map, key), do: Map.put(map, key, val)

  defp add_index_and_reduce(ascii_input, new_map, func) do
    ascii_input
    |> Enum.with_index(1)
    |> Enum.reduce(new_map, func)
  end
end
