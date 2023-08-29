defmodule App.Todo.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :person_id, :integer
    field :status, :integer
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:text, :person_id, :status])
    |> validate_required([:text])
    |> validate_number(:status, greater_than_or_equal_to: 0, less_than_or_equal_to: 2)
    # |> validate_required([:text, :person_id, :status])
  end

  @doc false
  def toggle(item) do
    item
    |> changeset(Map.update!(%{status: item.status}, :status, fn current_status -> if current_status == 0, do: 1, else: 0 end))
  end
end
