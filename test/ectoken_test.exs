defmodule EctokenTest do
  use ExUnit.Case
  doctest Ectoken

  test "encrypts" do
    plain_text = "ec_expire=3030"
    secret = "secret"
    iv = <<128, 28, 120, 25, 51, 120, 250, 166, 23, 92, 41, 98>>
    assert Ectoken.encrypt(secret, plain_text, iv) == "gBx4GTN4-qYXXCliNHS0R9RIffykChr_Faymx5b6fyXP0xldvqC26vK_"
  end

  test "expiry token" do
    iv = <<128, 28, 120, 25, 51, 120, 250, 166, 23, 92, 41, 98>>
    assert Ectoken.expiry_token("secret", 30, 3000, iv) == "gBx4GTN4-qYXXCliNHS0R9RIffykChr_Faymx5b6fyXP0xldvqC26vK_"
  end
end
