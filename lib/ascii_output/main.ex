defmodule AsciiOutput.Main do

  @type x :: integer
  @type y :: integer
  @type value :: any
  @type default :: any

  @type input_map :: %{{x,y} => value}
  @type ascii_char_fn :: (value -> String.t)
  @type filler :: String.t | default

  @type row_list :: list(col_list)
  @type col_list :: list(String.t)


  # TODO spec
  def ascii_output(input_map, ascii_char_fn, options) when is_list(options) do
    filler = Keyword.get(options, :filler, ".")
    size = Keyword.get(options, :size, nil)
    ascii_output(input_map, ascii_char_fn, filler, size)
  end

  @spec ascii_output(input_map, ascii_char_fn, filler) :: row_list
  def ascii_output(input_map, ascii_char_fn, filler \\ ".", overwrite_size \\ nil) do
    draw_tools = {ascii_char_fn, filler}
    size = overwrite_size || max_y(input_map)
    Enum.reduce(1..size, [], &output_add_row(&1, &2, input_map, draw_tools, overwrite_size))
    |> Enum.reverse()
  end

  @spec max_x(input_map) :: integer
  def max_x(input_map), do: max_some_key(input_map, &get_x_key/1)

  @spec max_y(input_map) :: integer
  def max_y(input_map), do: max_some_key(input_map, &get_y_key/1)


  defp output_add_row(row_num, row_list, input_map, draw_tools, overwrite_size) do
    size = overwrite_size || max_x(input_map)
    row =
      Enum.reduce(1..size, [], &output_add_col(&1, &2, row_num, input_map, draw_tools))
      |> Enum.reverse()

    [row | row_list]
  end

  defp output_add_col(col_num, col_list, row_num, input_map, {ascii_char_fn, filler}) do
    value = Map.get(input_map, {col_num, row_num})
    ascii =
      if value == nil do
        filler
      else
        ascii_char_fn.(value)
      end

    [ascii | col_list]
  end

  defp get_x_key({{x,_}, _}), do: x
  defp get_y_key({{_,y}, _}), do: y

  defp max_some_key(map, which_key_fn) do
    map
    |> Enum.map(which_key_fn)
    |> Enum.max
  end
end
