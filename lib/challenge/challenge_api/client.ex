defmodule Challenge.ChallengeApi.Client do
    use Tesla

    plug Tesla.Middleware.JSON
    plug Tesla.Middleware.Retry,
        delay: 500,
        max_retries: 10,
        max_delay: 4_000,
        should_retry: fn
            {:ok, %{status: status}} when status in [400, 500] -> true
            {:ok, _} -> false
            {:error, _} -> true
        end

    @base_url "http://challenge.dienekes.com.br/api/numbers?page="

    def get_numbers(page) do
        "#{@base_url}#{page}"
        |> get()
        |> handle_get()
    end

    # defp recursive_get(url) do
    #     case get(url) do
    #         {:ok, %Tesla.Env{status: 500}} -> recursive_get(url)
    #         result -> result
    #     end
    # end

    defp handle_get({:ok, %Tesla.Env{status: 200, body: body}}), do: {:ok, body}
    defp handle_get({:ok, %Tesla.Env{status: 404}}), do: {:error, "Page not found!"}
    defp handle_get({:error, _reason} = error), do: error

    # def get_page(page_number) do
    #     case Tesla.get("http://challenge.dienekes.com.br/api/numbers", query: [page: page_number]) do
    #       {:ok, %{status: 200, body: %{"numbers" => numbers}}} -> {:ok, numbers}
    #       {_tag, env_or_error} -> {:error, env_or_error}
    #     end
    #   end
      
    # def get_all_pages() do
    #     get_all_pages(1, [])
    # end
    
    # defp get_all_pages(page_number, acc) do
    #     case get_page(page_number) do
    #         {:ok, []} -> acc |> Enum.reverse() |> List.flatten()
    #         {:ok, numbers} -> get_all_pages(page_number + 1, [numbers | acc])
    #         {:error, reason} -> {:error, reason}
    #     end
    # end

end