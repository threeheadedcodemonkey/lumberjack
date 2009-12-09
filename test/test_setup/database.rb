begin
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
rescue ArgumentError
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")
end

ActiveRecord::Schema.define(:version => 1) do
  create_table :foos do |t|
    t.datetime    :created_at    
    t.datetime    :updated_at
    t.string      :name
    t.references  :user
  end

  create_table :bars do |t|
    t.datetime    :created_at    
    t.datetime    :updated_at
    t.string      :name
    t.references  :user
  end

  create_table :user_logs, :force => true do |t|
    t.integer   :user_id
    t.integer   :loggable_id
    t.string    :loggable_type
    t.string    :action
    t.string    :message
    t.datetime  :created_at
    t.datetime  :updated_at
  end

  create_table :users, :force => true do |t|
    t.string    :name
  end
end
