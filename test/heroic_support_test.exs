defmodule HeroicSupportTest do
  use ExUnit.Case
  doctest HeroicSupport

  test "greets the world" do
    assert HeroicSupport.hello() == :world
  end
end
