defmodule BancolombiaApp.Person do
  defstruct name: "", age: 0
  def new(), do: %__MODDULE__{}

  def increment_age(person) do
    %Person{person | age: person.age + 1}
  end

  def decrement_age(person) do
    %Person{person | age: person.age - 1}
  end

  def can_retire?(person, retirement_age) do
    person.age >= retirement_age
  end
end
