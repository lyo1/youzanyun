# frozen_string_literal: true

module Youzanyun

  class ResultHandler
    OK_CODE = 200.freeze
    OK_MSG  = "OK"
    attr_accessor :code, :message, :success, :result

    def initialize(code, message, success, result={})
      @code = code || OK_CODE
      @message = message || OK_MSG
      @success = success
      @result = package_result(result)
    end

    def is_ok?
      code == OK_CODE
    end
    alias_method :ok?, :is_ok?

    def full_message
      "#{code}: #{message}."
    end
    alias_method :full_messages, :full_message

    def full_error_message
      full_message if !is_ok?
    end
    alias_method :full_error_messages, :full_error_message
    alias_method :errors, :full_error_message

    private

    def package_result(result)
      return result if !result.is_a?(Hash)
      if defined?(Rails)
        ActiveSupport::HashWithIndifferentAccess.new(result)
      else
        result
      end
    end
  end
end