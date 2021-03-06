class AnswersController < ApplicationController
    # generated by running: rails g controller answers --skip-template-engine
    # skips generating view page
    before_action :authenticate_user!

    def create
        @question = Question.find params[:question_id]
        @answer = Answer.new answer_params
        @answer.question = @question # associate question and answer; comes from belongs_to
        @answer.user = current_user
        if @answer.save
            AnswerMailer.new_answer(@answer).deliver_now #.deliver_later if using smtp mailer
            redirect_to question_path(@question.id)
        else
            @answers = @question.answers.order(created_at: :desc)
            render 'questions/show'
            # can't do redirect_to because it will submit a GET request
            # and in the show page in question controller, a new instance variable is set
        end

        # render json: params
    end

    def destroy
        @answer = Answer.find params[:id]
        if can?(:crud, @answer)
            @answer.destroy
            redirect_to question_path(@answer.question_id)
        else
            head :unauthorized # head will send an empty HTTP response with a particular response code, in this case unauthorized - 401
            # redirect_to root_path, alert: "Not Authorized!"
        end
    end

    private

    def answer_params
        params.require(:answer).permit(:body)
    end
end
