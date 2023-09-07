defmodule ExSslOptions do
  @moduledoc """
  This module returns SSL options
  """

  @doc """
  SSL options according to [EEF Security WG recommandations](https://github.com/erlef/security-wg/blob/master/docs/secure_coding_and_deployment_hardening/ssl.md).
  """
  def eef_options do
    preferred_ciphers = [
      # Cipher suites (TLS 1.3): TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
      %{cipher: :aes_128_gcm, key_exchange: :any, mac: :aead, prf: :sha256},
      %{cipher: :aes_256_gcm, key_exchange: :any, mac: :aead, prf: :sha384},
      %{cipher: :chacha20_poly1305, key_exchange: :any, mac: :aead, prf: :sha256},
      # Cipher suites (TLS 1.2): ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:
      # ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:
      # ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
      %{cipher: :aes_128_gcm, key_exchange: :ecdhe_ecdsa, mac: :aead, prf: :sha256},
      %{cipher: :aes_128_gcm, key_exchange: :ecdhe_rsa, mac: :aead, prf: :sha256},
      %{cipher: :aes_256_gcm, key_exchange: :ecdh_ecdsa, mac: :aead, prf: :sha384},
      %{cipher: :aes_256_gcm, key_exchange: :ecdh_rsa, mac: :aead, prf: :sha384},
      %{cipher: :chacha20_poly1305, key_exchange: :ecdhe_ecdsa, mac: :aead, prf: :sha256},
      %{cipher: :chacha20_poly1305, key_exchange: :ecdhe_rsa, mac: :aead, prf: :sha256},
      %{cipher: :aes_128_gcm, key_exchange: :dhe_rsa, mac: :aead, prf: :sha256},
      %{cipher: :aes_256_gcm, key_exchange: :dhe_rsa, mac: :aead, prf: :sha384}
    ]

    ciphers = :ssl.filter_cipher_suites(preferred_ciphers, [])

    # Protocols: TLS 1.2, TLS 1.3
    versions = [:"tlsv1.2", :"tlsv1.3"]

    # TLS curves: X25519, prime256v1, secp384r1
    preferred_eccs = [:secp256r1, :secp384r1]
    eccs = :ssl.eccs() -- :ssl.eccs() -- preferred_eccs

    [
      verify: :verify_peer,
      depth: 5,
      cacerts: :certifi.cacerts(),
      customize_hostname_check: [
        {:match_fun, :public_key.pkix_verify_hostname_match_fun(:https)}
      ],
      ciphers: ciphers,
      versions: versions,
      eccs: eccs
    ]
  end
end
