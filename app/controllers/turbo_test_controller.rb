class TurboTestController < ApplicationController
  
  def index; end

  def create
    sleep 0.5 # Simulate processing
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.append('messages',
                              partial: 'turbo_test/message',
                              locals: { message: "Added at #{Time.now}" }),
          turbo_stream.update('counter',
                              html: "Count: #{rand(1..100)}")
        ]
      end
      format.html { redirect_to turbo_test_index_path }
    end
  end
end
