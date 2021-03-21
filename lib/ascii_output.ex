defmodule AsciiOutput do
  alias AsciiOutput.Main

  defdelegate draw(input_map), to: Main, as: :ascii_output
  defdelegate draw(input_map, options), to: Main, as: :ascii_output
end
