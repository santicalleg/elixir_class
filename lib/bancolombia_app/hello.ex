defmodule BancolombiaApp.Hello do

  def greet(target) do
    # IO.inspect("hello")
    receive do
      {:greet, message} ->
        IO.puts("Hello #{message}")
        send target, {:response, message}
        greet(target)

      {:bye, reason} ->
        IO.puts("Bye for #{reason}")
        send target, {:killed, target, reason}
      # {:EXIT, pid, reason} -> {:error}
      _ ->
        IO.puts "No message"
        greet(target)
        # code
    # after
    #   10000 -> IO.puts("Bye")
    end

  end

end

##Crear proceso
#pid = spawn(Hello, :greet, [])
##Enviar mensaje al proceso
#send pid, {:ok, "message"}
##Validar si el proceso está vivo
#Process.alive? pid
##Termina el proceso
#Process.exit pid, :kill
