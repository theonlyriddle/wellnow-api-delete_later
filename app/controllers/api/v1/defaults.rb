module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix "api"
        version "v1", using: :path
        default_format :json
        format :json
        formatter :json, Grape::Formatter::ActiveModelSerializers

        helpers do
          def permitted_params
            @permitted_params ||= declared(params, include_missing: false)
          end

          def logger
            Rails.logger
          end

          def set_locale
            logger.debug "* Accept-Language: #{env['HTTP_ACCEPT_LANGUAGE']}"
            I18n.locale = extract_locale_from_accept_language_header
            logger.debug "* Locale set to '#{I18n.locale}'"
          end

          def extract_locale_from_accept_language_header
            env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first || I18n.default_locale
          end
        end

        before do
          set_locale
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response(message: e.message, status: 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          error_response(message: e.message, status: 422)
        end
      end
    end
  end
end