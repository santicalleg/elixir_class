defmodule BancolombiaApp.TaskSupervisor do
  use Supervisor

  ## En este caso si aplica que el nombre (name) del supervisor si viva en toda la aplicación con el mismo nombre
  def start_link(init) do
    Supervisor.start_link(__MODULE__, init, name: __MODULE__)
  end

  def init(_init_arg) do
    children = [
      {BancolombiaApp.TaskServer, []}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

end
