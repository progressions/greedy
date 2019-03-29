defmodule Greedy.Schema do
  @moduledoc """
  Fetch and store schemas from kafka.

  This approach uses an Agent, which is the GenServer abstraction designed
  for storing state.

  On startup, it queries our Zookeeper instance at the url given in the
  @url property for the list of topics, then it queries each topic for
  its schema.

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

    all()
    |> Enum.map(&put(pid, &1["subject"], &1))

    {:ok, pid}
  end

  @doc """
  Fetch a schema from the local process's data store by name.
  """
  def get(pid, name) do
    Agent.get(pid, &Map.get(&1, name))
  end

  @doc """
  Store a schema in the local process's data store by name.
  """
  def put(pid, name, value) do
    Agent.update(pid, &Map.put(&1, name, value))
  end

  @doc """
  Fetch all the schemas.
  """
  def all do
    names()
    |> Enum.map(&load/1)
  end

  @doc """
  Fetch an Avro schema by name from our Zookeeper instance.
  """
  def load(name) do
    with {:ok, content} = request('/subjects/#{name}/versions/latest'),
         {:ok, %{"schema" => _schema} = raw} <- Poison.decode(content),
         do: raw
  end

  @doc """
  Collect the names of all the Avro schemas from our Zookeeper instance.
  """
  def names do
    with {:ok, content} <- request_all(),
         {:ok, values} <- Poison.decode(content),
         do: values
  end

  @doc """
  Request all topics from our Zookeeper instance.
  """
  def request_all do
    request('/subjects/')
  end

  @doc """
  Make a request to our Zookeeper instance.

  Its @url and @port are configured by the properties of those names.
  """
  def request(path) do
    url = '#{@url}:#{@port}#{path}'

    with {:ok, {{'HTTP/1.1', 200, 'OK'}, _, content}} <- :httpc.request(:get, {url, []}, [], []),
         do: {:ok, content}
  end
end
