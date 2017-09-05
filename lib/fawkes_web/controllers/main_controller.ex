defmodule FawkesWeb.MainController do
  use FawkesWeb, :controller

  require Logger

  def create(conn, params) do
    Logger.info "in create, params is #{inspect params}"
    text conn, :ets.insert(:fawkes_table, {params[:key], params[:value]})
  end

  def show(conn, params) do
    Logger.info "in show, params is #{inspect params}"
    text conn, :ets.lookup(:fawkes_table, params[:key])
  end
end
