defmodule AsciiOutput.Main do

  @type x :: integer
  @type y :: integer
  @type value :: any

  @type input_map :: %{{x,y} => value}
  @type ascii_char_fn :: (value -> String.t)

  @type row_list :: list(col_list)
  @type col_list :: list(String.t)

  @default_filler "."

  @spec ascii_output(input_map, ascii_char_fn) :: row_list
  def ascii_output(input_map, ascii_char_fn, filler \\ @default_filler) do
    # draw_tools = {ascii_char_fn, filler}
    Enum.reduce(1..max_y(input_map), [], &output_add_row(&1, &2, input_map, ascii_char_fn))
    |> Enum.reverse()
  end


  defp output_add_row(row_num, row_list, input_map, ascii_char_fn) do
    row =
      Enum.reduce(1..max_x(input_map), [], &output_add_col(&1, &2, row_num, input_map, ascii_char_fn))
      |> Enum.reverse()

    [row | row_list]
  end

  defp output_add_col(col_num, col_list, row_num, input_map, ascii_char_fn) do
    value = Map.get(input_map, {col_num, row_num})
    ascii =
      if value == nil do
        @default_filler
      else
        ascii_char_fn.(value)
      end

    [ascii | col_list]
  end

  # TODO defp
  def max_x(input_map) do
    get_x_key_fn()
    |> max_some_key(input_map)
  end
  def max_y(input_map) do
    get_y_key_fn()
    |> max_some_key(input_map)
  end

  defp get_x_key_fn(), do: fn {{x,_}, _} -> x end
  defp get_y_key_fn(), do: fn {{_,y}, _} -> y end

  defp max_some_key(which_key_fn, map) do
    map
    |> Enum.map(which_key_fn)
    |> Enum.max
  end
end
