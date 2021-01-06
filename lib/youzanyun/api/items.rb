# frozen_string_literal: true

module Youzanyun
  module Api
    module Item
      # 获取单个商品
      def items_inventory_get(options)
        http_get(url(".inventory.get"), options)
      end

      private

      def item_base_url
        "/youzan.items"
      end

      def version
        "/3.0.0"
      end

      def url(path)
        item_base_url + path + version
      end
    end
  end
end