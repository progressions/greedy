defmodule Greedy.Schema do
  @moduledoc """
  Fetch and store schemas from kafka.
  """

  use Agent

  @url 'http://10.0.100.250'
  @port '8081'

  def start_link(_opts) do
    {:ok, pid} = Agent.start_link(fn -> %{} end, name: :schemas)

    all() |> Enum.map(&put(pid, &1["subject"], &1))

    {:ok, pid}
  end

  def get(pid, name) do
    Agent.get(pid, &Map.get(&1, name))
  end

  def put(pid, name, value) do
    Agent.update(pid, &Map.put(&1, name, value))
  end

  @doc """
  Fetch all the schemas for topics matching 'fedora'.
  """
  def all do
    names()
    |> Enum.filter(&(&1 =~ ~r/fedora/))
    |> Enum.map(&load/1)
  end

  def load(name) do
    with {:ok, content} = request('/subjects/#{name}/versions/latest'),
         {:ok, %{"schema" => _schema} = raw} <- Poison.decode(content),
         do: raw
  end

  def names do
    with {:ok, content} <- request_all(),
         {:ok, values} <- Poison.decode(content),
         do: values
  end

  def request_all do
    request('/subjects/')
  end

  def request(path) do
    url = '#{@url}:#{@port}#{path}'

    with {:ok, {{'HTTP/1.1', 200, 'OK'}, _, content}} <- :httpc.request(:get, {url, []}, [], []),
         do: {:ok, content}
  end
end
