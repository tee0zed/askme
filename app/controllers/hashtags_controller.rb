class HashtagsController < ApplicationController
  before_action :load_hashtag, only: :show
  before_action :load_questions, only: :show

  def show
  end

  def index
    @hashtags = Hashtag.all
  end

  private

  def load_hashtag
    @hashtag = Hashtag.friendly.find(params[:id])
  end

  def load_questions
    @questions = @hashtag.questions
  end
end
