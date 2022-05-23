defmodule Challenge.Number do
    @keys [:numbers]

    @derive Jason.Encoder
    defstruct @keys

    def build(%{"numbers" => numbers}) do
        %__MODULE__{
            numbers: run(numbers)
        }
        # |> IO.inspect(limit: :infinity)
    end

    defp run(numbers) do
        numbers
        |> Stream.take_while(fn
           [] -> false
           _ -> true 
        end)
        |> Enum.to_list()
        |> sort_numbers()
    end

    defp sort_numbers(numbers) when length(numbers) <= 1, do: numbers

    defp sort_numbers(numbers) do
        {left, right} = Enum.split(numbers, div(length(numbers), 2))
        :lists.merge(sort_numbers(left), sort_numbers(right))
    end
end