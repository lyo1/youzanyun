# frozen_string_literal: true

# encoding: utf-8
module Youzanyun
  module Token
    class RedisStore < Store

      def valid?
        youzanyun_redis.del(client.redis_key)
        super
      end

      def token_expired?
        youzanyun_redis.hvals(client.redis_key).empty?
      end

      def refresh_token
        super
        youzanyun_redis.hmset(
          client.redis_key, "access_token",
          client.access_token, "expired_at",
          client.expired_at, "token_type",
          client.token_type
        )
        youzanyun_redis.expireat(client.redis_key, client.expired_at.to_i)
      end

      def access_token
        super
        client.access_token = youzanyun_redis.hget(client.redis_key, "access_token")
        client.expired_at   = youzanyun_redis.hget(client.redis_key, "expired_at")
        client.token_type   = youzanyun_redis.hget(client.redis_key, "token_type")
        client.access_token
      end

      def youzanyun_redis
        Youzanyun.youzanyun_redis
      end
    end
  end

end