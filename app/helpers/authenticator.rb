require 'openssl'

module Authenticator
  def encrypt(value)
    cipher = OpenSSL::Cipher.new('DES-EDE3-CBC').encrypt
    key = "\x95mC\x97\xBA[ls\xFB\xFC\xC6\xCA\xEA\xA0qG\x84\xB0\x83\x17Ywa\x8F"
    cipher.key = key
    s = cipher.update(value) + cipher.final

    s.unpack('H*')[0].upcase
  end
end