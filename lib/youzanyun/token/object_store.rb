# frozen_string_literal: true

# encoding: utf-8
module Youzanyun
  module Token
    class ObjectStore < Store

      def valid?
        super
      end

      def token_expired?
        client.expired_at <= Time.now.to_i
      end

      def refresh_token
        super
      end

      def access_token
        super
        client.access_token
      end
    end
  end
end