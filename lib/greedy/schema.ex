defmodule Greedy.Schema do
  @moduledoc """
  Fetch and store schemas from kafka.

  This approach uses an Agent, which is the GenServer abstraction designed
  for storing state.

  On startup, it queries our Zookeeper instance at the url given in the
  @url property for the list of topics matching the string 'teachable',
  then it queries each topic for its schema

  It then stores each topic's schema in a Map, with the key being the
  topic's name.

  If the topic name is "teachable.hook", then the schema name would be
  "teachable.hook-values".

  The schemas are now stored and available to fetch by name.

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
  Fetch all the schemas for topics matching 'teachable'.
  """
  def all do
    names()
    |> Enum.filter(&(&1 =~ ~r/teachable/))
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
