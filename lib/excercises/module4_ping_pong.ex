defmodule PingPong do

  #Execution with iex:
  #iex > pidPing = BancolombiaApp.PingPong.start()
  #iex > pidPong = BancolombiaApp.PingPong.start()
  #iex > PingPong.call(pidPing, {:ping, pidPong})

  def start() do
    spawn(__MODULE__, :loop, [])
  end

  def call(pid, msg) do
    send(pid, msg)
  end

  def handle_message({:ping, parent}) do
    IO.puts(">>>>> PING #{inspect(self())} - #{inspect(parent)}")
    :timer.sleep(3000)
    send(parent, {:pong, self()})
  end

  def handle_message({:pong, parent}) do
    IO.puts(">>>>> PONG #{inspect(self())} - #{inspect(parent)}")
    :timer.sleep(3000)
    send(parent, {:ping, self()})
  end

  def handle_message(_msg) do
    IO.puts(">>>>> ERROR <<<<<")
  end

  def loop() do
    receive do

      :kill -> :killed

      msg ->
        handle_message(msg)
        loop()
    end

  end

end
