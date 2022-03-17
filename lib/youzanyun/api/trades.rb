# frozen_string_literal: true

module Youzanyun
  module Api
    module Trades
      # 订单批量查询接口	
      def trades_sold_get(options)
        http_post(url(".sold.get"), options)
      end

      private

      def item_base_url
        "/youzan.trades"
      end

      def version
        "/4.0.2"
      end

      def url(path)
        item_base_url + path + version
      end
    end
  end
end