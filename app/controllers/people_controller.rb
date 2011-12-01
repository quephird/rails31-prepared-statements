class PeopleController < ApplicationController
  def index
    @people = Person.all
  end

  def show
    @person = Person.find(params[:id])
    render :partial => 'person', :locals => { :person => @person }
  end

  def new
    @person = Person.new
  end

  def edit
    @person = Person.find(params[:id])
    render :partial => 'form', :locals => { :person => @person }
  end

  def create
    @person = Person.new(params[:person])
    @person.save
  end

  def update
    @person = Person.find(params[:id])
    @person.update_attributes(params[:person])
    render :nothing => true
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    render :nothing => true
  end

  def filter_form
  end

  def filter
    filter_params = params.select {|k,v| k =~ /filter/ && v != ""}
    if filter_params.size > 0
      filter_names = filter_params.keys.map {|k| k.slice(7..-1)}
      filter_values = filter_params.values
      filter_method = "find_all_by_" + filter_names.join("_and_")
      @people = Person.send filter_method, *filter_values
    else
      @people = Person.all
    end
  end
end
