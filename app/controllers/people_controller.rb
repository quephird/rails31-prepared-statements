class PeopleController < ApplicationController
  # GET /people
  # GET /people.json
  def index
    @people = Person.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @people }
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])

    render :partial => 'person', :locals => { :person => @person }
#    respond_to do |format|
#      format.html # show.html.erb
#      format.json { render json: @person }
#    end
  end

  # GET /people/new
  # GET /people/new.json
  def new
    @person = Person.new

    respond_to do |format|
      format.html # new.html.erb
#      format.json { render json: @people }
      format.js
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])

    render :partial => 'form', :locals => { :person => @person }
#    respond_to do |format|
#      format.html # new.html.erb
#      format.js
#    end
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
#        format.json { render json: @people, status: :created, location: @people }
        format.js
      else
        format.html { render action: "new" }
#        format.json { render json: @people.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.json
  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url }
#      format.json { head :ok }
      format.js   { render :nothing => true }
    end
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

    respond_to do |format|
      format.html
      format.js
    end
  end
end
