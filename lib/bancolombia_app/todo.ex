defmodule BancolombiaApp.Todo do
  # defstruct :id, :description, :expire, :done
  defstruct id: nil, description: nil, expiration: nil, done?: false

  def new(description) do
    uuid = Ecto.UUID.generate()
    %__MODULE__{description: description, id: uuid}
  end

  def find(todo_list, query) do
    Enum.filter(todo_list, query)
  end

  def get(todo_list, id) do
    Enum.find(todo_list, fn todo -> todo.id == id end)
  end

  def update(todo, attrs) do
    Map.merge(todo, attrs)
  end

  def finish(todo) do
    %__MODULE__{todo | done?: true}
  end
end
