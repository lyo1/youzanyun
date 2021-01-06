# frozen_string_literal: true

require "youzanyun/version"
require "rest-client"
if defined? Yajl
  require 'yajl/json_gem'
else
  require "json"
end
require "erb"
require "youzanyun/config"
require "youzanyun/handler"
require "youzanyun/api"
require "youzanyun/client"
module Youzanyun

  CUSTOM_ENDPOINT = "custom_endpoint".freeze

  module Token
    autoload(:Store,       "youzanyun/token/store")
    autoload(:ObjectStore, "youzanyun/token/object_store")
    autoload(:RedisStore,  "youzanyun/token/redis_store")
  end

  class << self

    def http_get_without_token(url, url_params={}, endpoint="api")
      get_api_url = endpoint_url(endpoint, url)
      load_json(resource(get_api_url).get(params: url_params))
    end

    def http_post_without_token(url, post_body = {}, url_params = {}, endpoint="api")
      post_api_url = endpoint_url(endpoint, url)
      load_json(resource(post_api_url).post(JSON.generate(post_body), params: url_params))
    end

    def http_delete_without_token(url, delete_body={}, url_params={}, endpoint="plain")
      delete_api_url = endpoint_url(endpoint, url)
      load_json(resource(delete_api_url).delete(params: url_params,raw_response: true))
    end

    def resource(url)
      RestClient::Resource.new(url, rest_client_options)
    end

    def load_json(string)
      result_hash = JSON.parse(string.force_encoding("UTF-8").gsub(/[\u0011-\u001F]/, ""))
      ResultHandler.new(result_hash["code"], result_hash["message"], result_hash["success"], result_hash)
    end

    def endpoint_url(endpoint, url)
      return url if endpoint == CUSTOM_ENDPOINT
      send("#{endpoint}_endpoint") + url
    end

    def api_endpoint
      "https://open.youzanyun.com/api"
    end

    def calculate_expire(expires_in)
      expires_in.to_i - key_expired.to_i * 1000
    end
  end
end
