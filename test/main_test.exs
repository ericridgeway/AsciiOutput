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

  test "Alt params" do
    given_xy_map = %{
      # {4,1} => %{name: "c"},
      {4,1} => "c",
    }

    ascii_char_fn = &Map.get(&1, :name)

    assert Main.ascii_output(given_xy_map, ascii_char_fn: ascii_char_fn, size: 3) == [
      ~w[. . .],
      ~w[. . .],
      ~w[. . .],
    ]

    assert Main.ascii_output(given_xy_map) == [
      ~w[. . .],
      ~w[. . .],
      ~w[. . .],
    ]
  end

  # TODO next Decide how I want the param sig to look. The prob atm is ascii_char_fn being EITHER 2nd param OR bundled in [] as 2nd/3rd param is weird.
  # .if this gets annoying I can also always delete this entire branch and just lazily require them to put "." in the filler param to get to overwrite_size
end
