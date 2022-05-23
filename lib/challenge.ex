defmodule Challenge do
  alias Challenge.Number

  defdelegate fetch_numbers(), to: Number.Get, as: :call
end
