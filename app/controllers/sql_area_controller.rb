class SqlAreaController < ActionController::Base
  protect_from_forgery

  def cached_person_queries
    @cached_person_queries = SqlArea.cached_person_queries
    puts @cached_person_queries.length

    respond_to do |format|
      format.js
    end
  end

  def flush_query_cache
    SqlArea.flush_query_cache
    redirect_to :action => :cached_person_queries
  end

  def set_cursor_sharing_to_exact
    SqlArea.set_cursor_sharing_to_exact
    render :nothing => true
  end

  def set_cursor_sharing_to_force
    SqlArea.set_cursor_sharing_to_force
    render :nothing => true
  end
end