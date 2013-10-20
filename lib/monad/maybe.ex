defmodule Monad.Maybe do
  def bind({:just, x}, f), do: f.(x)
  def bind(:nothing, _), do: :nothing

  def return(x), do: {:just, x}

  def fail(_), do: :nothing
end
