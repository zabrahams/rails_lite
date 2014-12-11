require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = {}
      return unless req
      parse_www_encoded_form(req.query_string) if req.query_string
      parse_www_encoded_form(req.body) if req.body
      @params.merge(route_params)
    end

    def [](key)
      key = key.to_s if key.is_a?(Symbol)
      @params[key]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      queries = URI::decode_www_form(www_encoded_form)

      queries.each do |query|
        keys = parse_key(query[0])
        prev_level = @params
  
        keys.each_with_index do |key, i|

          unless prev_level.keys.include?(key)
            prev_level[key] = ( i == keys.count - 1 ? query[1] : {} )
          end

          prev_level = prev_level[key]
        end
      end
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
