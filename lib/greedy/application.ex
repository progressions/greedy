defmodule Greedy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  gen_consumer_impl = ExampleGenConsumer
  consumer_group_name = "example_group"
  topic_names = ["example_topic"]

  def start(_type, _args) do
    import Supervisor.Spec

    consumer_group_opts = [
      # setting for the ConsumerGroup
      heartbeat_interval: 1_000,
      # this setting will be forwarded to the GenConsumer
      commit_interval: 1_000
    ]

    gen_consumer_impl = Greedy.Consumer
    consumer_group_name = "kafka_ex"

    topic_names = [
      "fedora.user",
      "fedora-client-secure",
      "fedora-client",
      "fedora.school_subscription",
      "fedora-client.user",
      "fedora.School",
      "fedora.school_plan_subscription_change",
      "fedora-client-secure.School",
      "fedora-client.School",
      "fedora_client.School",
      "fedora.school"
    ]

    zchildren = [
      # ... other children
      supervisor(
        KafkaEx.ConsumerGroup,
        [gen_consumer_impl, consumer_group_name, topic_names, consumer_group_opts]
      )
    ]
    children = []

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
