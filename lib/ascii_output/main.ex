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
  def ascii_output(input_map, ascii_char_fn) do
    [
      ~w[a . . c],
      ~w[b . . .],
    ]
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
