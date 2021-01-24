defmodule AsciiOutputTest do
  use ExUnit.Case
  doctest AsciiOutput

  test "greets the world" do
    assert AsciiOutput.hello() == :world
  end
end
