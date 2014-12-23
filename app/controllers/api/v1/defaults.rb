module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix "api"
        version "v1", using: :path
        content_type :json, 'application/json ; charset = utf-8'
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
            Time.zone = 'UTC'
            Time.current.utc.iso8601
          end

          def extract_locale_from_accept_language_header
            logger.debug "* Frontend language '#{headers['Frontend-Language']}'"
            if (!headers['Frontend-Language'].nil?)
               headers['Frontend-Language']
            else
              env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first || I18n.default_locale
            end
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