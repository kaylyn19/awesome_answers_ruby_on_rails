class QuestionsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_question, only: [:show, :edit, :update, :destroy]
    before_action :authorize!, only: [:edit, :destroy, :update]

    def new
        @question = Question.new # to be able to access the view in a new instance
        # without this instance we wouldn't be able to use the helper form_for
        # can do this because there's already a model for this
    end

    def create
        p params
        # question_params = params.require(:question).permit(:title, :body)
        @question = Question.new question_params
        #  params.require(:question) name of the object
        # permit(:title, :body) only permitting title and body

        # on the params object, we are requesting question key.
        # we are only permitting the attributes of title and body for sercurity reasons
        # this has to be done to prevent sql injection because anything on the client sides is vulnerable
        @question.user = current_user # setting the relationship
        if @question.save
            flash[:notice] = "Question created successfully!"
            redirect_to question_path(@question.id)
        else
            render :new # finds 'new' in views
            # this can be written as: render 'new'
            # can't put it as a symbol if fetching html from a different folder
            # in that case, has to be written like '/contaacts/new'
        end
    end

    def show
        # For the 'form_with' helper
        @answer = Answer.new
        # For the list of answers
        @answers = @question.answers.order(created_at: :desc)
        @likes = @question.likes.count
    end

    def index
        if params[:tag]
            @tag = Tag.find_by(name: params[:tag])
            @questions = @tag.questions.order(created_at: :desc)
        else
            @questions = Question.order(created_at: :desc)
        end
    end

    def edit
    end

    def update
        # first, grab the object
        # question_params = params.require(:question).permit(:title, :body)
        if @question.update question_params
            redirect_to question_path(@question)
        else
            render :edit
        end
    end

    def destroy
        flash[:notice] = "Question deleted!"
        # question = Question.find params[:id]
        # find_question.destroy
        @question.destroy
        redirect_to questions_path
    end

    private

    def question_params
        params.require(:question).permit(:title, :body, :tag_names)# {tag_ids: []})
    end

    def find_question
        @question = Question.find params[:id]
        # if you are not going to view, you don't have to keep the variable an instance variable
    end

    def authorize!
        redirect_to root_path, alert: "Not Authorized" unless can?(:crud, @question)
    end
end

