class MeetingsController < ApplicationController
  def index
    if params[:tag]
      @meetings = Tag.find_by(name: params[:tag]).meetings
    else
      @meetings = Meeting.all
    end
    render "index.html.erb"
  end

  def show
    @meeting = Meeting.find_by(id: params[:id])
    render "show.html.erb"
  end

  def new
    @meeting = Meeting.new
    @tags = Tag.all
  end

  def create
    @meeting = Meeting.new(
      name: params[:name],
      address: params[:address],
      start_time: params[:start_time],
      end_time: params[:end_time],
      notes: params[:notes],
      )
    if @meeting.save
      params[:tags].each do |tag_id|
        MeetingTag.create(
          meeting_id: @meeting.id,
          tag_id: tag_id
        )
      end
      flash[:success] = "Meeting Successfully Created!"
      redirect_to '/'
    else
      @tags = Tag.all
      render :new
    end
  end

  def edit
    @meeting = Meeting.find(params[:id])
    @tags = Tag.all
    render :edit
  end

  def update
    @meeting = Meeting.find(params[:id])
    if @meeting.update(
      name: params[:name],
      address: params[:address],
      start_time: params[:start_time],
      end_time: params[:end_time],
      notes: params[:notes],
      )
      @meeting.tags.destroy_all
      params[:tags].each do |tag_id|
        MeetingTag.create(
          meeting_id: @meeting.id,
          tag_id: tag_id
        )
      end
      flash[:success] = "Meeting Successfully Updated!"
      redirect_to meeting_path(@meeting)
    else
      @tags = Tag.all
      render :edit
    end
  end

  def delete
    
  end
end










