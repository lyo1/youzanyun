# frozen_string_literal: true

module Youzanyun
  module Api
    module Users
      # 用户查询查询接口	
      def users_info_query(options)
        http_post(url(".info.query"), options)
      end

      private

      def item_base_url
        "/youzan.users"
      end

      def version
        "/1.0.0"
      end

      def url(path)
        item_base_url + path + version
      end
    end
  end
end