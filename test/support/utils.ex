defmodule Test.Support.Utils do
  @moduledoc """
  Utility generator functions for testing.
  """

  def generate_id(length \\ 32),
    do: length |> div(2) |> :crypto.strong_rand_bytes() |> Base.encode16(case: :lower)
end
