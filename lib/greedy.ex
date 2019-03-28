defmodule Greedy do
  @moduledoc """
  Documentation for Greedy.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Greedy.hello()
      :world

  """
  def hello do
    :world
  end

  def latest do
    Greedy.fetch() |> Greedy.messages() |> Greedy.values()
  end

  def fetch(topic \\ "fedora.user") do
    KafkaEx.fetch(topic, 0, offset: 0)
  end

  def messages([%{partitions: [%{message_set: messages}]}]), do: messages

  def values(messages) do
    messages
    |> Enum.map(& &1.value)
    |> Enum.map(&remove_bits/1)
    |> Enum.map(&parse_value/1)
    |> Enum.map(&parse_metadata/1)
  end

  def remove_bits(<<0, 0, 0, 0, 13>> <> rest), do: rest

  def parse_value(value) do
    {:ok, value} =
      schema()
      |> AvroEx.decode(value)

    value
  end

  def parse_metadata(%{"metadata" => metadata_json} = value) do
    {:ok, metadata} = Poison.decode(metadata_json)

    value |> Map.put("metadata", metadata)
  end

  def schema do
    %{
      "subject" => "fedora.user-value",
      "version" => 1,
      "id" => 13,
      "schema" =>
        "{\"type\":\"record\",\"name\":\"event\",\"namespace\":\"eventable.testing\",\"fields\":[{\"name\":\"source\",\"type\":\"string\"},{\"name\":\"noun\",\"type\":[\"string\",\"null\"]},{\"name\":\"verb\",\"type\":[\"string\",\"null\"]},{\"name\":\"noun_id\",\"type\":[\"string\",\"int\",\"null\"]},{\"name\":\"metadata\",\"type\":[\"string\",\"null\"]},{\"name\":\"received_at\",\"type\":\"string\"},{\"name\":\"created_at\",\"type\":[\"long\",\"int\",\"float\",\"double\",\"string\",\"null\"]}],\"__fastavro_parsed\":true}"
    }
    |> parse_schema()
  end

  def parse_schema(%{"schema" => schema_json}) do
    AvroEx.parse_schema!(schema_json)
  end
end
