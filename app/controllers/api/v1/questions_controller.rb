class Api::V1::QuestionsController < Api::ApplicationController
    #  rails g controller api::v1::questions --skip-template-engine
    # can also add the following options
    # --no-assets --no-helper
    # having v1: allow people who are on an older version can have the code work
    # clients are not forced to upgrade 
    # subsequent versions are inherited from v1
    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_question, only: [:show, :destroy]
    def index
        questions = Question.order(created_at: :desc)
        render(json: questions, each_serializer: QuestionCollectionSerializer)
    end

    def show
        render(json: @question,
        # We need to do this to make sure that Rails
        # includes the nested user association for answers
        # (which is renamed to author in the serializer).
        include: [ :author, {answers: [ :author ]} ]
        )
    end

    def create
        question = Question.new question_params
        question.user = current_user
        if question.save
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
end
