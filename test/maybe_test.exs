defmodule MaybeTest do
  use ExUnit.Case
  import Monad
  import Monad.Maybe

  test "Monad.Maybe left identity" do
    f = fn (x) -> x * x end
    a = 2
    assert bind(return(a), f) == f.(a)
  end

  test "Monad.Maybe right identity" do
    m = return 42
    assert bind(m, &return/1) == m
  end

  test "Monad.Maybe associativity" do
    f = fn (x) -> x * x end
    g = fn (x) -> x - 1 end
    m = return 2
    assert bind(return(bind(m, f)), g) == bind(m, &bind(return(f.(&1)), g))
  end

  test "Monad.Maybe successful bind" do
    assert (m_do Monad.Maybe do
              x <- just 2
              y <- just 4
              return (x * y)
            end) == {:just, 8}
  end

  test "Monad.Maybe failing bind" do
    assert (m_do Monad.Maybe do
              x <- just 2
              y <- fail "Yes, we can"
              return (x * y)
            end) == :nothing
  end
end
