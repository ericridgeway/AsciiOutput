defmodule AsciiOutputTest.FromAsciiInput do
  use ExUnit.Case

  alias AsciiOutput.{FromAsciiInput}

  test "Draw from ascii input" do
    ascii_input = [
      ~w[o . .],
      ~w[. x .],
    ]
    translater = %{"o" => :apple}

    assert ascii_input |> FromAsciiInput.generate_map(translater) == %{
      {1,1} => :apple,
      {2,2} => "x",
    }
  end

  #delete? bug isnt this side looks like...
  test "Infinite loop bug" do
    ascii_input = [
      ~w[o o .],
      ~w[. o o],
    ]
    translater = %{"o" => :road}

    assert ascii_input |> FromAsciiInput.generate_map(translater) == %{
      {1,1} => :road,
      {2,1} => :road,
      {2,2} => :road,
      {3,2} => :road,
    }
  end
end
