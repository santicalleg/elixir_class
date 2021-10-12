defmodule BancolombiaApp.TaskServer do
  use GenServer

  # ** Con el name se puede identificar el proceso, porque en al algun momento se quiere identificar un proceso por el nombre
  #No usar con fines de negocio sino para fines de estructura de la aplicación
  #Identificar un proceso unicamente incluso a través de nodos
  #No es coherente utilizarlo por ejemplo para crear solo una lista de tasks para toda la aplicación
  def start_link(_args) do
    # ** # GenServer.start_link(__MODULE__, args, name: MyTask)

    #Ejemplo ejecución
    # iex(3)> {:ok, pid} = BancolombiaApp.TaskServer.start_link(10)
    # Args: 10
    # {:ok, #PID<0.245.0>}
    #Si en los argumentos viene valor, se ejecuta el init y adiciona el valor al state (no ejecuta la función handle_cast)
    # GenServer.start_link(__MODULE__, args, [])
    GenServer.start_link(__MODULE__, [])
  end

  ## Client impl

  def list(server) do
    GenServer.call(server, :get)
  end

  ## De esta forma funcionaría si tuviera el mismo nombre del módulo, es decir, creando el proceso de la siguiente manera:
  ## GenServer.start_link(__MODULE__, args, name: __MODULE__)
  # def list() do
  #   GenServer.call(__MODULE__, :get)
  # end

  def put(server, task) do
    GenServer.cast(server, {:put, task})
  end

  ## De esta forma funcionaría si tuviera el mismo nombre del módulo, es decir, creando el proceso de la siguiente manera:
  ## GenServer.start_link(__MODULE__, args, name: __MODULE__)
  # def put(task) do
  #   GenServer.cast(__MODULE__, {:put, task})
  # end

  @impl true
  def init(args) do
    IO.puts("Args: #{args}")
    {:ok, args}
  end

  #síncrona, espera una respuesta cuando se mande a ejecutar la llamada
  #Se parece en handle_message que vimos en ejemplos pasados, donde request es la tupla, from el parent(self()) y el state
  # def handle_call(request, from, state) do
  @impl true
  def handle_call(:get, _from, state) do
    #{atomo que indique que va responder, la respuesta, el nuevo estado}
    IO.puts("handle_call invoqued")
    {:reply, state ,state}
  end

  #asíncrona, modifica el estado sin responder
  # def handle_cast(request, state) do
  @impl true
  def handle_cast({:put, element}, state) do
    IO.puts("handle_cast invoqued")
    {:noreply, [element | state]}
  end
end
