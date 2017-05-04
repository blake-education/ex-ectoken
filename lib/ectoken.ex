defmodule Ectoken do
  @moduledoc """
  Documentation for Ectoken.
  """

  @doc """


  ## Examples

      iex> iv = <<128, 28, 120, 25, 51, 120, 250, 166, 23, 92, 41, 98>>
      iex> Ectoken.encrypt("secret", "ec_expire=3030", iv)
      "gBx4GTN4-qYXXCliNHS0R9RIffykChr_Faymx5b6fyXP0xldvqC26vK_"

  """
  def encrypt(secret, plain_text, iv) do
    aes_blocksize = 32
    <<keyhash :: binary-size(aes_blocksize)>> <> _rest = :crypto.hash(:sha256, secret)

    {cipher_text, cipher_tag} = :crypto.block_encrypt(:aes_gcm, keyhash, iv, {"", plain_text}) 

    output = iv <> cipher_text <> cipher_tag |> Base.url_encode64
    String.replace_trailing(output, "=", "")
  end

  @doc """


  ## Examples

      iex> iv = <<128, 28, 120, 25, 51, 120, 250, 166, 23, 92, 41, 98>>
      iex> Ectoken.expiry_token('secret', 30, 3000, iv)
      "gBx4GTN4-qYXXCliNHS0R9RIffykChr_Faymx5b6fyXP0xldvqC26vK_"

  """
  def expiry_token(secret, expiry, now, iv) do
    expire_at = now + expiry
    plain_text = "ec_expire=#{expire_at}"

    encrypt(secret, plain_text, iv)
  end

  @doc """
  """
  def expiry_token(secret, expiry, now) do
    iv = :crypto.strong_rand_bytes(12)

    expiry_token(secret, expiry, now, iv)
  end

  def expiry_token(secret, expiry) do
    now = DateTime.to_unix(DateTime.utc_now())

    expiry_token(secret, expiry, now)
  end
end
