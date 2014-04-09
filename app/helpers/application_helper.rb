module ApplicationHelper
  def flash_class(type)
    {
      notice: "alert alert-info",
      success: "alert alert-success",
      error: "alert alert-danger",
      alert: "alert alert-warning"
    }[type]
  end
end
