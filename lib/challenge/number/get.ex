defmodule Challenge.Number.Get do
    alias Challenge.ChallengeApi.Client
    alias Challenge.Number

    def call() do        
        page = 1

        page
        |> recursive_call()

        # page
        # |> Client.get_numbers()
        # |> handle_response()
    end

    defp recursive_call(page) do
        # Task.async(fn ->
        #     page
        #     |> Client.get_numbers()
        #     |> handle_response()
        # end)

        page
        |> Client.get_numbers()
        |> handle_response()
        
        page = page + 1

        if page <= 2 do
            recursive_call(page)
        end

        # recursive_call(page)
    end

    defp handle_response({:ok, body: %{"numbers" => []}}), do: {:ok, "STOP THE RECURSION"}
    defp handle_response({:ok, body}), do: {:ok, Number.build(body)}
    defp handle_response({:error, _reason} = error), do: error
end