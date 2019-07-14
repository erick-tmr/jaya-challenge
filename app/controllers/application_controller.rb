class ApplicationController < ActionController::API
  ACTIVE_RECORDS_COLLECTION_CLASSES = [
    'ActiveRecord::Relation',
    'ActiveRecord::Associations::CollectionProxy'
  ].freeze
  CONTENT_TYPE = 'application/vnd.api+json'.freeze

  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  protected

  def render_json_response(opts = {})
    resources = opts.fetch(:resources)
    serializer = opts.fetch(:serializer)
    options = opts.fetch(:options, {})
    status = opts.fetch(:status, :ok)

    serialized_response = serializer.new(
      resources,
      { is_collection: collection?(resources) }.merge(options)
    ).serializable_hash

    render json: serialized_response, status: status, content_type: CONTENT_TYPE
  end

  private

  def collection?(resources)
    resources.is_a?(Array) || ACTIVE_RECORDS_COLLECTION_CLASSES.include?(resources.class.name)
  end

  def not_found_response
    render json: {
      errors: [
        { source: :resource, title: 'Requested resource not found.' }
      ]
    }, status: :not_found, content_type: CONTENT_TYPE
  end
end
