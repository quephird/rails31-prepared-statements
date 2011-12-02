Rails31PreparedStatements::Application.routes.draw do
  resources :people do
    collection do
      get "filter_form"
      get "filter"
    end
  end

  get "sql_area/cached_person_queries"

  post "sql_area/flush_query_cache"
  post "sql_area/set_cursor_sharing_to_exact"
  post "sql_area/set_cursor_sharing_to_force"
end
