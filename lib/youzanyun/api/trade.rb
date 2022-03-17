# frozen_string_literal: true

module Youzanyun
  module Api
    module Trade
      # 查询单笔交易详情接口
      def trade_get(options)
        http_post(url(".get"), options)
      end

      private

      def item_base_url
        "/youzan.trade"
      end

      def version
        "/4.0.1"
      end

      def url(path)
        item_base_url + path + version
      end
    end
  end
end