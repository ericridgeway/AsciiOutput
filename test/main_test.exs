defmodule AsciiOutputTest.Main do
  use ExUnit.Case

  alias AsciiOutput.{Main}

  test "Given an xy map, draw ascii" do
    given_xy_map = %{
      {1,1} => %{name: "a"},
      {1,2} => %{name: "b"},
      {4,1} => %{name: "c"},
    }

    ascii_char_fn = &Map.get(&1, :name)

    assert Main.ascii_output(given_xy_map, ascii_char_fn) == [
      ~w[a . . c],
      ~w[b . . .],
    ]
  end

  test "Alternate default value" do
    given_xy_map = %{
      {5,1} => %{name: "x"},
    }

    ascii_char_fn = &Map.get(&1, :name)

    assert Main.ascii_output(given_xy_map, ascii_char_fn, "0") == [
      ~w[0 0 0 0 x],
    ]
  end

  test "Overwrite size" do
    given_xy_map = %{
      {4,1} => %{name: "c"},
    }

    ascii_char_fn = &Map.get(&1, :name)

    assert Main.ascii_output(given_xy_map, ascii_char_fn, ".", 3) == [
      ~w[. . .],
      ~w[. . .],
      ~w[. . .],
    ]
  end
end
