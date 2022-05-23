defmodule ChallengeWeb.NumbersController do
    use ChallengeWeb, :controller

    def index(conn, _params) do
        Challenge.fetch_numbers()
        |> handle_response(conn)
    end

    defp handle_response({:ok, numbers}, conn) do
        conn
        |> put_status(:ok)
        |> json(numbers)
    end

    defp handle_response({:error, _reason} = error, _conn), do: error
end