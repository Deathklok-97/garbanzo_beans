defmodule EmailGenerator.Tests do
  use ExUnitProperties

  domains = ["gmail.com", "yahoo.com", "icloud.com", "hotmail.com"]

  email_generator =
    ExUnitProperties.gen all name <- StreamData.string(:alphanumeric),
                             name != "",
                             domain <- StreamData.member_of(domains) do
      name <> "@" <> domain
    end

end
