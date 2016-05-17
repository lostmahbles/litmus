class Api::V1::StatusController < ApiController
  def create
    @status_update = StatusUpdate.new(status_update_params)

    if @status_update.save
      render json: { current_status: current_status }
    else
      render json: { current_status: current_status,
                     errors:         @status_update.errors }, 
             status: :bad_request
    end
  end

  private

  def status_update_params
    p = params.permit(:system_status, :message)
  end
end
