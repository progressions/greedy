defmodule Greedy.Consumer do
  use KafkaEx.GenConsumer

  alias KafkaEx.Protocol.Fetch.Message

  require Logger

  # note - messages are delivered in batches
  def handle_message_set(message_set, state) do
    for %Message{value: message} <- message_set do
      Logger.debug(fn -> "message: " <> inspect(message) end)

      value =
        message
        |> Greedy.remove_bits()
        |> Greedy.parse_value()
        |> Greedy.parse_metadata()

      Logger.debug(fn -> "value: " <> inspect(value) end)
    end

    {:async_commit, state}
  end
end
