defmodule BancolombiaApp.GenericServer do

  def start(module, init) do
    #se usa para que no termine el proceso asociado al padre anidado (self() o la iex)
    #y se pueda manipular para hacer algo mas con la respuesta
    #Evitar que el prceso que lo creo muera, y el proceso que lo invoca reciba la razon por la que finalizó
    Process.flag(:trap_exit, true)
    parent = self()
    #asocia el nuevo proceso al proceso que lo invoca, en ejemplos, el proceso de la iex
    spawn_link(__MODULE__, :loop, [module, parent, init])
    ##otra forma de llamar la funcion
    #spawn(fn -> loop(module, parent) end)
  end

  #Comportamiento para abstraer el llamado de la funcion send
  def call(pid, message) do
    send(pid, message)
  end

  def loop(callback_module, parent, state) do
    receive do
      :kill -> :killed

      msg ->
        {:ok, new_state} = callback_module.handle_message(msg, parent, state)
        loop(callback_module, parent, new_state)
    end
  end

end
