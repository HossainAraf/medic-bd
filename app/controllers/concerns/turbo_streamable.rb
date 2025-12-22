module TurboStreamable
  extend ActiveSupport::Concern
  
  included do
    respond_to :html, :turbo_stream
  end
  
  def turbo_redirect_to(path, **options)
    respond_to do |format|
      format.html { redirect_to path, **options }
      format.turbo_stream { redirect_via_turbo_stream_to path, **options }
    end
  end
  
  private
  
  def redirect_via_turbo_stream_to(path, **options)
    render turbo_stream: turbo_stream.update(
      "turbo-redirect",
      "<script>window.location = '#{path}'</script>"
    )
  end
end