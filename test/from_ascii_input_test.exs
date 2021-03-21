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
end
