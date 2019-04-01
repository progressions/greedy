defmodule Greedy.Consumer do
  @moduledoc """
  KafkaEx example consumer.

  """
  use KafkaEx.GenConsumer

  alias KafkaEx.Protocol.Fetch.Message

  require Logger

  # note - messages are delivered in batches
  def handle_message_set(message_set, state) do
    for %Message{value: _value} = message <- message_set do
      value =
        message
        |> Greedy.decode("teachable.hook")

      Task.async(fn -> Process.sleep(2_000); Logger.debug(fn -> inspect(value) end) end)

      Logger.debug(fn -> "value: " <> inspect(value) end)
    end

    {:async_commit, state}
  end
end
