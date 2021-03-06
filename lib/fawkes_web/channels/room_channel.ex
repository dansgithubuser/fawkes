defmodule FawkesWeb.RoomChannel do
  use Phoenix.Channel

  require Logger

  import Ecto.Query

  alias Fawkes.{Repo, Pair}

  def join("room:" <> private_room_id, _params, socket) do
    Logger.info "room #{private_room_id} joined"
    {:ok, socket}
  end

  def handle_in("write", params, socket) do
    params = Poison.Parser.parse!(params)
    key = params["key"]
    value = params["value"]
    nil = Repo.one(from i in Pair, where: i.key == ^key, select: i.value)
    Repo.insert!(%Pair{key: key, value: value})
    Logger.info "associating key #{key} with value #{value}"
    {:noreply, socket}
  end

  def handle_in("read", params, socket) do
    params = Poison.Parser.parse!(params)
    key = params["key"]
    value = Repo.one!(from i in Pair, where: i.key == ^key, select: i.value)
    Logger.info "replying value #{value} for key #{key}"
    {:reply, {:ok, %{"key": key, "value": value}}, socket}
  end
end
