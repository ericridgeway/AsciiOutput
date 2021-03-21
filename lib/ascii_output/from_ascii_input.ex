defmodule AsciiOutput.FromAsciiInput do
  @type ascii_input :: [row]
  @type row :: [key]
  @type key :: String.t
  @type translater :: %{key => any}


  @spec generate_map(ascii_input, translater) :: Main.input_map
  def generate_map(ascii_input, translater) do
   ascii_input
    |> Enum.with_index(1)
    # |> Enum.reduce(Map.new, &rows_from_ascii/2)
    |> Enum.reduce(Map.new, &row_from_ascii(&1, &2, translater))
  end


  defp row_from_ascii({row, row_num}, new_map, translater) do
    row
    |> Enum.with_index(1)
    |> Enum.reduce(new_map, &col_from_ascii(&1, &2, row_num, translater))
  end

  defp col_from_ascii({col, col_num}, new_map, row_num, translater) do
    if col == "." do
      new_map
    else
      translation =
        case Map.get(translater, col) do
          nil -> col
          string_key -> string_key
        end

        Map.put(new_map, {col_num, row_num}, translation)
    end
  end

end
