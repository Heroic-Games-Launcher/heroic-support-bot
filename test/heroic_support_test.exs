defmodule HeroicSupportTest do
  use ExUnit.Case
  doctest HeroicSupport

  test "extracts 0x0.st log link from message" do
    content = """
    Hi! this is my log https://0x0.st/1234.log
    """

    assert HeroicSupport.find_links(content) == [
             ["https://0x0.st/1234.log", "https://0x0.st/1234.log"]
           ]
  end

  test "extracts oxo.st log link from message" do
    content = """
    Hi! this is my log https://oxo.st/4321.log
    """

    assert HeroicSupport.find_links(content) == [
             ["https://0x0.st/4321.log", "https://0x0.st/4321.log"]
           ]
  end

  test "extracts multiple logs" do
    content = """
    Hi! these are my logs https://0x0.st/1234.log and https://oxo.st/4321.log
    """

    assert HeroicSupport.find_links(content) == [
             ["https://0x0.st/1234.log", "https://0x0.st/1234.log"],
             ["https://0x0.st/4321.log", "https://0x0.st/4321.log"]
           ]
  end

  test "ignores logs with not issues detected" do
    results = [
      [["log1.log", "https://example.com/log1.log"], []],
      [["log2.log", "https://example.com/log2.log"], ["missingRosetta"]]
    ]

    assert HeroicSupport.results_to_message(results),
           "\"log2.log\" analyzed:\n#{HeroicSupport.check_to_string("missingRosetta")}"

    results = [
      [["log1.log", "https://example.com/log1.log"], ["DXVKRequiresNewerDriver"]],
      [["log2.log", "https://example.com/log2.log"], ["missingRosetta"]]
    ]

    assert HeroicSupport.results_to_message(results),
           "\"log1.log\" analyzed:\n#{HeroicSupport.check_to_string("DXVKRequiresNewerDriver")}\n\n\"log2.log\" analyzed:\n#{HeroicSupport.check_to_string("missingRosetta")}"

    results = [
      [["log1.log", "https://example.com/log1.log"], []]
    ]

    assert HeroicSupport.results_to_message(results), ""
  end

  test "converts macos version to string" do
    assert HeroicSupport.check_to_string(["outdatedMacOsVersion", [26, 3, 0]]) ==
             "Your MacOS version is not the latest. Updating to the latest version is known to fix some game issues, update to at least version 26.3.0"
  end
end
