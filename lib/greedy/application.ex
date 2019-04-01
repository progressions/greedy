defmodule Greedy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    consumer_group_opts = [
      # setting for the ConsumerGroup
      heartbeat_interval: 1_000,
      # this setting will be forwarded to the GenConsumer
      commit_interval: 1_000
    ]

    consumer_group_name = "kafka_ex"

    topic_names = [
      "teachable.hook"
    ]

    children = [
      supervisor(
        KafkaEx.ConsumerGroup,
        [Greedy.Consumer, consumer_group_name, topic_names, consumer_group_opts]
      ),
      Greedy.SchemaSupervisor
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end

  # this was the setup for the GenStage experiment.
  def nuthin do
    """
    children = [
      worker(A, [0]),
      worker(B, [2]),
      worker(C, []),
    ]

    Supervisor.start_link(children, strategy: :rest_for_one)
    """
  end
end
