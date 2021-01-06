# frozen_string_literal: true

module Youzanyun
  module Token
    class Store

      attr_accessor :client

      def initialize(client)
        @client = client
      end

      def self.init_with(client)
        if Youzanyun.youzanyun_redis.nil?
          ObjectStore.new(client)
        else
          RedisStore.new(client)
        end
      end

      def valid?
        authenticate["valid"]
      end

      def authenticate
        auth_result = http_get_access_token
        auth = false
        if auth_result.is_ok?
          set_access_token(auth_result.result)
          auth = true
        end
        {"valid" => auth, "handler" => auth_result}
      end

      def refresh_token
        handle_valid_exception
        set_access_token
      end

      def access_token
        refresh_token if token_expired?
      end

      def token_expired?
        raise NotImplementedError, "Subclasses must implement a token_expired? method"
      end

      def set_access_token(access_token_infos=nil)
        token_infos = access_token_infos || http_get_access_token.result
        client.access_token = token_infos["data"]["access_token"]
        client.expired_at = Youzanyun.calculate_expire(token_infos["data"]["expires"])
      end

      def http_get_access_token
        Youzanyun.http_post_without_token("https://open.youzanyun.com/auth/token", authenticate_headers, {}, CUSTOM_ENDPOINT)
      end

      def authenticate_headers
        {
          client_id: client.client_id,
          client_secret: client.client_secret,
          authorize_type: "silent",
          grant_id: client.grant_id
        }
      end

      private

        def handle_valid_exception
          auth_result = authenticate
          if !auth_result["valid"]
            result_handler = auth_result["handler"]
            raise ValidAccessTokenException, result_handler.full_error_message
          end
        end
    end
  end
end