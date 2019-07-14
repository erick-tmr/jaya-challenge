module Api
  module Webhooks
    class GithubListenerController < ApplicationController
      def listen
        unless valid_github_signature?
          return render(
            json: { error: 'Could not recognize payload signature.' },
            status: :internal_server_error
          )
        end

        ::IssueEventParser.call(payload: params)

        render json: { message: 'ok' }
      end

      private

      def request_payload
        @request_payload ||= request.body.read
      end

      def valid_github_signature?
        signature = ::Security::GithubPayloadDigester.call(
          payload: request_payload,
          secret_key: Rails.application.credentials[:github][:webhook_secret]
        )

        Rack::Utils.secure_compare(signature, request.headers['X-Hub-Signature'])
      end
    end
  end
end
