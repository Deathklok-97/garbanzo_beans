defmodule Ecto.Schemas.Tests do
  use ExUnit.Case
  alias Ecto.Changeset

  alias User

  @expected_fields_with_types [
    { :email, :string},
    { :name, :string},
    { :id, :binary_id},
    { :inserted_at, :naive_datetime},
    { :updated_at, :naive_datetime}
  ]

  describe "fields and types" do
    @tag :schema_definition

    test "has correct fields and types" do
      actual_fields_with_types =
        for field <- User.__schema__(:fields) do
          type = User.__schema__(:type, field)
          {field, type}
        end

        assert MapSet.new(actual_fields_with_types) == MapSet.new(@expected_fields_with_types)
    end
  end

  defp yesterday, do: DateTime.utc_now() |> Date.add(-1)

    defp valid_params(fields_with_types) do
    valid_value_by_type = %{
      string: fn -> Faker.Lorem.word() end,
      date: fn -> Faker.DateTime.between(yesterday(), DateTime.utc_now()) end,
      binary_id: fn -> Faker.Util.digit() end,
      native_datetime: fn -> Faker.NaiveDateTime.between(yesterday(), NativeDateTime.utc_now()) end
    }

  for {field, type} <- fields_with_types, into: %{} do
    {Atom.to_string(field), valid_value_by_type[type].()}
  end

end

end
