defmodule A do
  use GenStage

  def start_link(number) do
    GenStage.start_link(A, number, name: A, max_demand: 10)
  end

  def init(counter) do
    {:producer, counter}
  end

  def handle_demand(demand, counter) when demand > 0 do
    # If the counter is 3 and we ask for 2 items, we will
    # emit the items 3 and 4, and set the state to 5.
    # events = Enum.to_list(counter..counter+demand-1)

    IO.inspect(%{demand: demand, counter: counter})

    events = KafkaEx.fetch("foo", 0, offset: counter)
             |> Enum.take(demand)

    {:noreply, events, counter + demand}
  end
end
