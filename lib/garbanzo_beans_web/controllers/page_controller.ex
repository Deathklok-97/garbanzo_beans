defmodule GarbanzoBeansWeb.PageController do
  use GarbanzoBeansWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
