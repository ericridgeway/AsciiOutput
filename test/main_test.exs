defmodule AsciiOutputTest.Main do
  use ExUnit.Case

  alias AsciiOutput.{Main}

  test "TODO" do
    given_xy_map = %{
      {1,1} => %{name: "a"},
      {1,2} => %{name: "b"},
      {4,1} => %{name: "c"},
    }

    # ascii_char_fn = fn map -> map.name end
    ascii_char_fn = &Map.get(&1, :name)

    assert Main.ascii_output(given_xy_map, ascii_char_fn) == [
      ~w[a . . c],
      ~w[b . . .],
    ]
  end
end
