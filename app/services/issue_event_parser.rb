class IssueEventParser
  include Instrumentation::BaseService

  def initialize(opts = {})
    @payload = opts.fetch(:payload, '')
  end

  def call
    parse_payload
  end

  private

  def parse_payload
    {
      issue_id: @payload[:issue][:id],
      action: @payload[:action],
      payload: @payload.to_json
    }
  end
end
