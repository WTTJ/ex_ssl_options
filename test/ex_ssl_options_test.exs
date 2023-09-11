defmodule ExSslOptionsTest do
  use ExUnit.Case, async: true
  doctest ExSslOptions

  @allowed_keys [:verify, :depth, :cacerts, :customize_hostname_check, :ciphers, :versions, :eccs]

  test "should return EEF SSL options" do
    options = ExSslOptions.eef_options()
    assert is_list(options)
    assert Keyword.keys(options) == @allowed_keys
  end

  test "should return basic SSL options" do
    options = ExSslOptions.basic_options()
    assert is_list(options)
    assert Keyword.keys(options) -- @allowed_keys == []
  end
end
