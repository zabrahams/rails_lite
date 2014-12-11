class Flash

  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    flash_cookie = req.cookies.find { |cookie| cookie.name == "_rails_lite_flash" }
    @to_flash = (flash_cookie ? JSON.parse(flash_cookie.value) : {} )
    @next_flash = {}
  end

  def now
    @to_flash
  end

  def [](key)
    @next_flash[key]
  end

  def []=(key, val)
    @next_flash[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_flash(res)
    res.cookies << WEBrick::Cookie.new('_rails_lite_flash', @next_flash.to_json)
  end

end
