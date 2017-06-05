class EncryptedCoder
  def load(value)
    return if value.nil?

    Marshal.load(
      Crypt.decrypt(
        Base64.decode64(value)
      )
    )
  end

  def dump(value)
    Base64.encode64(
      Crypt.encrypt(
        Marshal.dump(value)
      )
    )
  end
end
