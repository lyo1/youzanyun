# frozen_string_literal: true

require "monitor"
require "redis"
require 'digest/md5'
module Youzanyun

  class Client

    include MonitorMixin

    include Api::Item

    attr_accessor :client_id, :client_secret, :grant_id, :expired_at
    attr_accessor :access_token, :token_type, :redis_key

    def initialize(client_id, client_secret, grant_id, options={})
      self.client_id = client_id
      self.client_secret = client_secret
      self.expired_at = Time.now.to_i
      self.grant_id =  grant_id
      self.redis_key = security_redis_key(options[:redis_key] || "youzanyun_#{client_id}")
      super()
    end

    def get_access_token
      synchronize { token_store.access_token }
    end

    def get_token_type
      synchronize { token_store.token_type }
    end

    def is_valid?
      token_store.valid?
    end

    def token_store
      Token::Store.init_with(self)
    end

    def http_get(url, url_params={}, endpoint="api")
      url_params = url_params.merge(access_token_param)
      Youzanyun.http_get_without_token(url, url_params, endpoint)
    end

    def http_post(url, post_body={}, url_params={}, endpoint="api")
      url_params = access_token_param.merge(url_params)
      Youzanyun.http_post_without_token(url, post_body, url_params, endpoint)
    end

    def http_delete(url, delete_body={}, url_params={}, endpoint="api")
      url_params = access_token_param.merge(url_params)
      url = "#{url}?access_token=#{get_access_token}"
      Youzanyun.http_delete_without_token(url, delete_body, url_params, endpoint)
    end

    def verify?(event_sign:, body:)
      str = client_id + body + client_secret
      Digest::MD5.hexdigest(str) == event_sign
    end

    private

    def access_token_param
      { access_token: get_access_token }
    end

    def security_redis_key(key)
      Digest::MD5.hexdigest(key.to_s).upcase
    end
  end
end
