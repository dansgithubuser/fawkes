defmodule FawkesWeb.RoomChannel do
  use Phoenix.Channel

  require Logger

  def join("room:" <> private_room_id, _params, socket) do
    Logger.info "room #{private_room_id} joined"
    {:ok, socket}
  end

  def handle_in("write", params, socket) do
    params = Poison.Parser.parse!(params)
    key = params["key"]
    value = params["value"]
    {:ok, _} = :dets.open_file(:fawkes_table, [type: :set])
    if :dets.insert_new(:fawkes_table, {key, value}) do
      Logger.info "associating key #{key} with value #{value}"
    else
      Logger.info "key #{key} already has association"
    end
    :ok = :dets.close(:fawkes_table)
    {:noreply, socket}
  end

  def handle_in("read", params, socket) do
    params = Poison.Parser.parse!(params)
    key = params["key"]
    {:ok, _} = :dets.open_file(:fawkes_table, [type: :set])
    value = elem(hd(:dets.lookup(:fawkes_table, key)), 1)
    Logger.info "replying value #{value} for key #{key}"
    {:reply, {:ok, %{"key": key, "value": value}}, socket}
  end
end
