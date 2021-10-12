# BancolombiaApp

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `bancolombia_app` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bancolombia_app, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/bancolombia_app](https://hexdocs.pm/bancolombia_app).

Agregar un modulo a iex
c "path/project/module"
c "lib/bancolombia_app/fibonacci.ex"

# ===

Crear un proceso
pid = spawn(fn -> 1 + 1 end)
Process.alive? pid
Process.info pid

Enviar mensajes al proceso
send pid, mensaje
send pid, {:compute, n}

Buena practica usar __MODULE__ para hacer referencia al nombre del mismo modulo

# ===

Nodos distribuidos
iex --sname node_name
conectar dos nodos, los nodos para la conexión los reconoce como átomos dentro de la beam
Node.ping :"nombre_maquina"
Node.ping :"node_2@Santiagos-MacBook-Pro-2"
Si la conexión es correcta, responde el átomo :pong
Si la conexión es incorrecta, responde el átomo :pang

Obtener el código de un nodo principal
Node.spawn_link :"foo@computer-name", fn -> Hello.world end

Lider de grupo, determina quién podría ser candidato a iniciar todos los procesos. 
No existe maestros y esclavos. Todos son nodos y entre todos se hablan.
El lider de grupo sirven para saber hacia donde encaminar flujos, datos o mensajes.
Quiere decir que se puede indicar que los logs vayan al lider de grupo.

Indicar quién es el lider de grupo, sobre la iex 
:global.register_name(:one, :erlang.group_leader)

Buscar un nodo con el nombre que se otorgó con el comando ejecutaddo anteriormente (tener en cuenta que deben de estar conectados o descubiertos, con Nodde.ping)
node = :global.whereis_name :one

Estando en el nodo_x que no es lider de grupo, enviarle una salida de consola al nodo lider de grupo
iex(node_2)> IO.puts node, "Hello World"

registrar un proceso como server (eso se entendió en la clase)
Anteriormente se creó un modulo de ejemplo para recibir mensajes:
defmodule Remote do
  def loop do
    receive do
      msg -> "Got a message #{inspect msg}"
    end
    loop()
  end
end

iex(node_1)> :global.register_name :server, pid

## Ejercicio PingPong distribuido
Node 1:
iex --sname ping_node -S mix

Node 2:
iex --sname pong_node
Node.ping :"ping_node@Santiagos-MacBook-Pro-2"
pongPid = Node.spawn_link(:"ping_node@Santiagos-MacBook-Pro-2", fn -> BancolombiaApp.PingPong.loop end)

Node 1:
pingPid = BancolombiaApp.PingPong.start()
:global.register_name(:ping_server, pingPid) //Registrar el server con el proceso

Node 2:
pingPid = :global.whereis_name(:ping_server) //descubrir el proceso generado en el nodo 1
send(pingPid, {:pong, pongPid}) //comenzar ping-pong entre nodos
# ===

GenServer

Llamadas síncronas y asíncronas
Síncrona: Espera una respuesta cuando se mande a ejecutar la llamada
Asíncrona: 

# ===

table_ref = :ets.new(:todo_registry, [:set, :protected])
:ets.insert table_ref, {1, "uno"}
:ets.insert table_ref, {2, "dos"}
:ets.lookup table_ref, 1

:mnesia.create_schema([node()])
:mnesia.start
:mnesia.create_table(Todo, [attributes: [:description, :id, :experimentation]])
:mnesia.dirty_write({Todo, "test", 1, DateTime.utc_now})
:mnesia.dirty_read({Todo, "test"})
:mnesia.transaction(fn -> end)