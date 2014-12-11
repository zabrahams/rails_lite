module UrlHelper

  def link_to(text, url)
    "<a href='#{html_escape(url)}'>#{html_escape(text)}</a>"
  end

  def button_to(text, url, method)

  end


end
