module Security
  class GithubPayloadDigester
    include ::Instrumentation::BaseService

    def initialize(opts = {})
      @payload = opts.fetch(:payload, '')
      @secret_key = opts.fetch(:secret_key)
    end

    def call
      digest_payload
    end

    private

    def digest_payload
      digested_payload = OpenSSL::HMAC.hexdigest(
        OpenSSL::Digest.new('sha1'),
        @secret_key,
        @payload
      )

      "sha1=#{digested_payload}"
    end
  end
end
