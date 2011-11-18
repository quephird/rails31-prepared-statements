class SqlArea < ActiveRecord::Base
  def self.cached_person_queries
    SqlArea.connection.select_all(
      "select  sql_text
       from    sys.v_$sqlarea
       where   sql_text like '%PEOPLE%'
       and     sql_text not like '%sqlarea'
       and     sql_text not like '%sqlarea%'
       and     sql_text not like '%all_constraints%'
       and     sql_text not like '%all_tab_cols%'
       and     sql_text not like '%all_triggers%'
       order by last_load_time"
       )
  end

  def self.set_cursor_sharing_to_exact
    SqlArea.connection.execute "alter session set cursor_sharing = 'EXACT'"
  end

  def self.set_cursor_sharing_to_force
    SqlArea.connection.execute "alter session set cursor_sharing = 'FORCE'"
  end

  def self.flush_query_cache
    SqlArea.connection.execute "alter system flush shared_pool"
  end
end
