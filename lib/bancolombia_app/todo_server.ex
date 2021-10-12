##Use
## {:ok, pid} = BancolombiaApp.TodoServer.start_link
## BancolombiaApp.TodoServer.list pid
## BancolombiaApp.TodoServer.find "84r8e34-4w34t3-453e1e"
## BancolombiaApp.TodoServer.update pid, %Todo{description: "--", --, id: "..."}
## BancolombiaApp.TodoServer.put pid, %Todo{description: "any"}
## BancolombiaApp.TodoServer.finish pid, "84r8e34-4w34t3-453e1e"

defmodule BancolombiaApp.TodoServer do
  use GenServer
  alias BancolombiaApp.Todo

  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end

  ##Client impl
  def list(pid) do
   GenServer.call(pid, :get)
  end

  def find(pid, id) do
    GenServer.call(pid, {:find, id})
  end

  def update(pid, todo) do
    GenServer.cast(pid, {:update, todo})
  end

  def put(pid, todo) do
    GenServer.cast(pid, {:put, todo})
  end

  def finish(pid, id) do
    ## TODO: Set behavior
    GenServer.cast(pid, {:finish, id})
  end

  ##Callbacks impl
  @impl true
  def init(args) do
    {:ok, args}
  end

  @impl true
  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_call({:find, id}, _from, state) do
    todo = Todo.get(state, id)
    {:reply, todo, state}
  end

  @impl true
  def handle_cast({:put, todo}, state) do
    {:noreply, [todo | state]}
  end

  @impl true
  def handle_cast({:update, todo}, state) do
    #find todo and update todo
    found_todo = Todo.get(state, todo.id)

    case found_todo do
      nil -> {:noreply, state}
      %BancolombiaApp.Todo{} ->
        new_state = List.delete(state, found_todo)
        updated_todo = Todo.update(found_todo, todo)
        {:noreply, [updated_todo | new_state]}
    end

  end

  @impl true
  def handle_cast({:finish, id}, state) do
    todo = Todo.get(state, id)

    case todo do
      nil -> {:noreply, state}
      %BancolombiaApp.Todo{} ->
        new_state = List.delete(state, todo)
        finished_todo = Todo.finish(todo)
        {:noreply, [finished_todo | new_state]}
    end

  end

end
