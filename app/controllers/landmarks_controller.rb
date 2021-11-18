class LandmarksController < ApplicationController
  # add controller methods

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/new' do
    @figures = Figure.all
    erb :'/landmarks/new'
  end

  post '/landmarks' do
    @landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    if !params[:figure][:name].empty?
      @landmark.figure = Figure.create(name: params[:figure][:name])
    end
    @landmark.save
    redirect "landmarks/#{@landmark.id}"
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @figures = Figure.all
    @landmark = Landmark.find(params[:id])
    erb :'/landmarks/edit'
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    
    if !params[:landmark].include?("figure_id")
      params[:landmark]["figure_id"] = []
    end

    @landmark.update(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    
    if !params[:figure][:name].empty?
      @landmark.figure = Figure.create(name: params[:figure][:name])
    end

    @landmark.save
   
    redirect "landmarks/#{@landmark.id}"
  end

end
