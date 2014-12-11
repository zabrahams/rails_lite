module Phase2
  class ControllerBase
    attr_reader :req, :res

    # Setup the controller
    def initialize(req, res)
      @req, @res = req, res
    end

    # Helper method to alias @already_built_response
    def already_built_response?
      @already_built_response || false
    end

    # Set the response status code and header
    def redirect_to(url)
      raise "Already Rendered" if already_built_response?
      @already_built_response = true
      @res.status = 302
      @res['Location'] = url
    end

    # Populate the response with content.
    # Set the response's content type to the given type.
    # Raise an error if the developer tries to double render.
    def render_content(content, type)
      raise "Already Rendered" if already_built_response?
      @already_built_response = true
      @res['Content-Type'] = type
      @res.body = content
    end
  end
end
