# frozen_string_literal: true

module Youzanyun
  module Api
    module Item
      # 获取单个商品
      def item_get(options)
        http_get(url(".get"), options)
      end

      def item_sku_update(options)
        http_post(url(".sku.update"), options)
      end

      private

      def item_base_url
        "/youzan.item"
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