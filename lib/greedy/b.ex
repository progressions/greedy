defmodule B do
  use GenStage

  def start_link(number) do
    GenStage.start_link(B, number, name: B)
  end

  def init(number) do
    {:producer_consumer, number, subscribe_to: [{A, max_demand: 10}]}
  end

  def handle_events(events, _from, number) do
    events =
      events
      |> Greedy.messages()
      |> Greedy.values("foo")

    {:noreply, events, number}
  end
end
