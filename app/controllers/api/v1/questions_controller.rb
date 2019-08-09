class Api::V1::QuestionsController < Api::ApplicationController
    #  rails g controller api::v1::questions --skip-template-engine
    # can also add the following options
    # --no-assets --no-helper
    # having v1: allow people who are on an older version can have the code work
    # clients are not forced to upgrade 
    # subsequent versions are inherited from v1
    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_question, only: [:show, :destroy]
    rescue_from(ActiveRecord::RecordNotFound, with: :record_not_found)
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
        questions = Question.order(created_at: :desc)
        render(json: questions, each_serializer: QuestionCollectionSerializer)
    end

    def show
        if @question
            render(json: @question,
            # We need to do this to make sure that Rails
            # includes the nested user association for answers
            # (which is renamed to author in the serializer).
            include: [ :author, {answers: [ :author ]} ]
            )
        else
            render json: {error: 'question not found', status: 404}, status: 404
        end
    end

    def create
        question = Question.new question_params
        question.user = current_user
        if question.save! # saving with a bang will throw an exception
            render json: { id: question.id }
        else
            render(
                json: { errors: question.errors },
                status: 422 # unprocessable Entity; HTTP status quo
            )
        end
    end

    def destroy
        @question.destroy
        render(json: {status: 200}, status: 200)
    end


    private

    def find_question
        @question ||= Question.find params[:id]
    end

    def question_params
        params.require(:question).permit(:title, :body, :tag_names)
    end

    def record_not_found
        render(
            json: {status: 422, errors: {msg: 'record not found'}},
            status: 422
        )
    end

    def record_invalid(error) #error.record.errors
        invalid_record = error.record
        errors = invalid_record.errors.map do |field, message|
            {
                type: error.class.to_s,
                record_type: invalid_record.class.to_s,
                field: field,
                message: message
            }
        end
        render(
            json: {status: 422, errors: errors}
        )
    end
end
