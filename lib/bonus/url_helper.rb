require 'htmlentities'

module ApplicationHelper

  def link_to(text, url)
    "<a href='#{html_escape(url)}'>#{html_escape(text)}</a>"
  end

  def button_to(text, url, method="POST")
    <<-HTML
    <form action="#{html_escape(url)}" method="POST">
      <input type="hidden" name="_method" value="#{html_escape(method)}">
      <input type="submit" value"#{html_escape(text)}">
    </form>
    HTML
  end

  def html_escape(text)
    coder = HTMLEntities.new
    coder.encode(text)
  end


end

module UrlHelper






end
