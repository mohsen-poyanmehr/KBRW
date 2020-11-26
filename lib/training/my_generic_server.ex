defmodule MyGenericServer do
  use GenServer

  def loop(amount, c, n, type) when n <= 1 do
    if type === "credit", do: cast(amount, {:credit, c})
    if type === "debit", do: cast(amount, {:debit, c})
    IO.puts("#{call(amount)}")
  end

  def loop(amount, c, n, type) do
    if type === "credit", do: cast(amount, {:credit, c})
    if type === "debit", do: cast(amount, {:debit, c})
    loop(amount, c, n - 1, type)
  end

  ## Client API

  def start_link(amount) do
    GenServer.start_link(__MODULE__, amount)
  end

  def cast(amount, {:credit, c}) do
    GenServer.cast(amount, {:credit, c})
  end

  def cast(amount, {:debit, c}) do
    GenServer.cast(amount, {:debit, c})
  end

  def call(amount) do
    GenServer.call(amount, :call)
  end

  ## Defining GenServer Callbacks

  @impl true
  def init(amount) do
    {:ok, amount}
  end

  @impl true
  def handle_cast({:credit, c}, amount) do
    {:noreply, amount + c}
  end

  @impl true
  def handle_cast({:debit, c}, amount) do
    {:noreply, amount - c}
  end

  @impl true
  def handle_call(:call, _from, amount) do
    {:reply, amount, amount}
  end
end
