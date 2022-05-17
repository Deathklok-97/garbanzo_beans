defmodule User do
  use GarbanzoBeans.Schema

  embedded_schema do
    field :name, :string
    field :email, :string

     timestamps()
  end





end
