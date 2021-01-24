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
    input_map
    |> Enum.map(fn {{x,_y}, _value} -> x end)
    |> Enum.max
  end
  def max_y(input_map) do
    input_map
    |> Enum.map(fn {{_x,y}, _value} -> y end)
    |> Enum.max
  end

end
