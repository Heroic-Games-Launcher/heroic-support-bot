defmodule HeroicSupportTest do
  use ExUnit.Case
  doctest HeroicSupport

  test "extracts 0x0.st log link from message" do
    content = """
    Hi! this is my log https://0x0.st/1234.log
    """

    assert HeroicSupport.find_links(content) == [["1234.log", "https://0x0.st/1234.log"]]
  end

  test "extracts oxo.st log link from message" do
    content = """
    Hi! this is my log https://oxo.st/4321.log
    """

    assert HeroicSupport.find_links(content) == [["4321.log", "https://0x0.st/4321.log"]]
  end

  test "extracts multiple logs" do
    content = """
    Hi! these are my logs https://0x0.st/1234.log and https://oxo.st/4321.log
    """

    assert HeroicSupport.find_links(content) == [
             ["1234.log", "https://0x0.st/1234.log"],
             ["4321.log", "https://0x0.st/4321.log"]
           ]
  end
end
