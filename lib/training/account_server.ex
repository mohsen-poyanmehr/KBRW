defmodule AccountServer do
  require MyGenericServer

  {:ok, my_account} = MyGenericServer.start_link(4)
  MyGenericServer.cast(my_account, {:credit, 5})
  MyGenericServer.cast(my_account, {:credit, 2})
  MyGenericServer.cast(my_account, {:debit, 3})
  amount = MyGenericServer.call(my_account)
  IO.puts("current credit hold is #{amount}")
  {:ok, my_account} = MyGenericServer.start_link(0)
  IO.puts("current credit after reset with 5 debit loop")
  MyGenericServer.loop(my_account, 5, 5, "debit")
end
