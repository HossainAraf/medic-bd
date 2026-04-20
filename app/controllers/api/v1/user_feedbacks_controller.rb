class Api::V1::UserFeedbacksController < Api::BaseController
  before_action :authorize_admin, except: %i[index create]
  skip_before_action :authorize_request, only: %i[index create]
  def index
    user_feedbacks = UserFeedback.order(created_at: :desc)
    render json: user_feedbacks
  end

  def create
    user_feedback = UserFeedback.new(user_feedback_params)
    if user_feedback.save
      render json: user_feedback, status: :created
    else
      render json: user_feedback.errors, status: :unprocessable_content
    end
  end

  def update
    user_feedback = UserFeedback.find_by(id: params[:id])
    if user_feedback
      if user_feedback.update(user_feedback_params)
        render json: user_feedback, status: :ok # Respond with the updated feedback data
      else
        render json: { error: 'Failed to update feedback' }, status: :unprocessable_content
      end
    else
      render json: { error: 'User feedback not found' }, status: :not_found
    end
  end

  def destroy
    user_feedback = UserFeedback.find_by(id: params[:id])
    if user_feedback
      user_feedback.destroy
      head :no_content # This responds with 204
    else
      render json: { error: 'User feedback not found' }, status: :not_found
    end
  end

  private

  def user_feedback_params
    params.expect(user_feedback: %i[name email feedback phone])
  end
end
