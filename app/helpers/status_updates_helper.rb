module StatusUpdatesHelper
  def current_status_header(status:)
    render partial: "status_updates/current_status_header", locals: { status: status }
  end

  def status_history
    render partial: "status_updates/history", locals: { updates: @status_updates }
  end

  def status_history_empty_state
    render partial: "status_updates/history_empty_state"
  end

  def status_history_item(update:)
    render partial: "status_updates/history_item", object: update
  end
end
