defmodule GarbanzoBeans.Schema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @timestamp_opts [type: :utc_datetime]

      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
    end
  end
end
