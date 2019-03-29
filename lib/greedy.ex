defmodule Greedy do
  @moduledoc """
  Sandbox for experimenting with Kafka.
  """

  @doc """
  Fetch a bunch of records from the "fedora.user" topic in Kafka.

  Fetches records and parses the Avros-encoded values and then parses the
  JSON metadata within.
  """
  def latest(topic \\ "fedora.user") do
    Greedy.fetch(topic)
    |> Greedy.messages()
    |> Greedy.values(topic)
  end

  @doc """
  Fetch all the messages for a given topic from Kafka.

  This is a brute-force approach, not caring about which messages we've
  seen before. This is just for development and figuring out how to do
  this.
  """
  def fetch(topic \\ "fedora.user") do
    KafkaEx.fetch(topic, 0, offset: 0)
  end

  @doc """
  Reach into the complex structure returned and just get the messages.
  """
  def messages([%{partitions: [%{message_set: messages}]}]), do: messages

  @doc """
  Grab all the Avro-encoded `value` attributes out of the messages and
  decode them.
  """
  def values(messages, topic) do
    messages
    |> Enum.map(& decode_value(&1, topic))
  end

  @doc """
  Decodes a single Avro-encoded message, looking up its schema
  by the topic given.

  Once the message is encoded, the value's `metadata` field is still
  encoded as JSON, so we decode that field as well.
  """
  def decode_value(message, topic) do
    message.value
    |> parse_schema_id()
    |> parse_encoded_value(topic)
    |> parse_metadata()
  end

  @doc """
  These bits identify the schema. The last bit is 13, which is
  the id of the schema we use.

  Currently we only use one schema for all our data, but that
  could change as we move forward with the webhooks project.

  I think the ideal approach in the long run might be to get
  the ID out of this value and use that to fetch the schema.
  """
  def parse_schema_id(<<0, 0, 0, 0, id>> <> rest), do: {id, rest}

  @doc """
  Parse the Avro-encoded value we get from Kafka.

  This uses the AvroEx package, and the schema based on the
  topic we've requested, to parse the `value` we get from
  Kafka.

  The version of Avro we use stores some boilerplate data in
  the first 5 bytes, with the 5th byte being the ID of the
  schema used to encode the value.

  If those bytes haven't been removed, this function won't
  work.
  """
  def parse_encoded_value({_id, value}, topic) do
    with {:ok, value} <- AvroEx.decode(schema("#{topic}-value"), value),
         do: value
  end

  def parse_metadata(%{"metadata" => metadata_json} = value) do
    {:ok, metadata} = Poison.decode(metadata_json)

    value
    |> Map.put("metadata", metadata)
  end

  def schema(name) do
    Greedy.Schema.get(:schemas, name)
    |> parse_schema()
  end

  def parse_schema(%{"schema" => schema_json}) do
    AvroEx.parse_schema!(schema_json)
  end
end
