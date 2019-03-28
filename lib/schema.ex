defmodule Greedy.Schema do
  @url 'http://10.0.100.250'
  @port '8081'

  def all do
    schema_names()
    |> Enum.filter(& &1 =~ ~r/fedora/)
    |> Enum.map(&load/1)
  end

  def load(name) do
    {:ok, content} = request('/subjects/#{name}/versions/latest')

    with {:ok, %{"schema" => schema} = raw} <- Poison.decode(content),
         {:ok, schema} <- Poison.decode(schema), do: raw |> Map.put("schema", schema)
  end

  def schema_names do
    with {:ok, content} <- request_all(),
         {:ok, values} <- Poison.decode(content),
         do: values
  end

  def request_all do
    request('/subjects/')
  end

  def request(path) do
    url = '#{@url}:#{@port}#{path}'
    with {:ok, {{'HTTP/1.1', 200, 'OK'}, _, content}} <- :httpc.request(:get, {url, []}, [], []), do: {:ok, content}
  end
end
