defmodule Greedy.Schema do

  def all do
    schema_names()
    |> Enum.filter(& &1 =~ ~r/fedora/)
    |> Enum.map(&load/1)
  end

  def load(name) do
    {:ok, content} = request('http://10.0.100.250:8081/subjects/#{name}/versions/latest')

    with {:ok, %{"schema" => schema} = raw} <- Poison.decode(content),
         {:ok, schema} <- Poison.decode(schema), do: raw |> Map.put("schema", schema)
  end

  def schema_names do
    with {:ok, content} <- request_all(),
         {:ok, values} <- Poison.decode(content),
         do: values
  end

  def request_all do
    request('http://10.0.100.250:8081/subjects/')
  end

  def request(path) do
    with {:ok, {{'HTTP/1.1', 200, 'OK'}, _, content}} <- :httpc.request(:get, {path, []}, [], []), do: {:ok, content}
  end
end
