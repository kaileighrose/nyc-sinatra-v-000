class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end
  
  get '/figures/new' do
    erb :'/figures/new'
  end

  post '/figures' do 
    @figure = Figure.create(params[:figure])
    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(params["landmark"])
    end
    if !params["title"]["name"].empty?
      new_title = Title.create(params["title"])
      @figure.titles << new_title
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/edit'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end

  patch '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.update(params[:figure])
    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(params["landmark"])
    else
      @figure.landmarks << Landmark.find_by_id(params["figure"]["landmark_ids"])
    end
    if !params["title"]["name"].empty?
      new_title = Title.create(params["title"])
      @figure.title_ids << new_title.id
    else
      @figure.title_ids << params["figure"]["title_ids"]
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end
end