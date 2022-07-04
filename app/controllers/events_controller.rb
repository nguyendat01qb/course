class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  before_action :set_course

  def index
    @events = Event.all
  end

  def show; end

  def new
    @event = Event.new
  end

  def edit; end

  def create
    @event = current_user.events.new(event_params)
    if @event.save
      flash[:success] = 'Event was successfully created.'
      redirect_to event_url(@event)
    else
      flash[:error] = 'Course creation failed'
      render :new
    end
  end

  def update
    if @event.update(event_params)
      flash[:success] = 'Event was successfully updated.'
      redirect_to event_url(@event)
    else
      flash[:error] = 'Course update failed'
      render :edit
    end
  end

  def destroy
    if @event.destroy
      flash[:success] = 'Event was successfully destroyed.'
      redirect_to events_url
    else
      flash[:error] = 'Failed destroy event'
    end
  end

  private

  def set_course
    @course_event = Course.all.to_a
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:course_id, :start_time, :end_time, :address, :total_slot, :booked_slot, :cost)
  end
end
