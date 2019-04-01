defmodule HookTask do
  use Task

  def start_link(arg) do
    Task.start_link(__MODULE__, :run, [arg])
  end

  def run(arg) do
    IO.inspect(arg)
  end
end
