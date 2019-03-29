defmodule Greedy do
  @moduledoc """
  Sandbox for experimenting with Kafka.
  """

  @doc """
  Fetch a bunch of records from the "fedora.user" topic in Kafka.

  Fetches records and parses the Avros-encoded values and then parses the
  JSON metadata within.
  """
  def latest do
    Greedy.fetch()
    |> Greedy.messages()
    |> Greedy.values()
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

  # I believe these bits identify the schema. The last bit is 13, which is
  # the id of the "fedora.user" schema.
  #
  def remove_bits(<<0, 0, 0, 0, 13>> <> rest), do: rest

  def parse_value(value) do
    with {:ok, value} <- AvroEx.decode(schema(), value),
         do: value
  end

  def parse_metadata(%{"metadata" => metadata_json} = value) do
    {:ok, metadata} = Poison.decode(metadata_json)

    value |> Map.put("metadata", metadata)
  end

  def schema do
    Greedy.Schema.get(:schemas, "fedora.user-value")
    |> parse_schema()
  end

  def parse_schema(%{"schema" => schema_json}) do
    AvroEx.parse_schema!(schema_json)
  end
end
