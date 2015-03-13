class SqlSolutionsController < ApplicationController

  def create
  	user_id = current_user.id
    challenge_id = params["solution"]["challenge_id"]
  	method_string = params["solution"]["method_string"]
    language = "SQL"

    challenge = Challenge.find(challenge_id)
    if current_user.have_solved?(challenge, language)
      flash[:errors] = ["You already solved this challenge in SQL."]
      redirect_to user_url(current_user)
      return
    end

  	@solution = Solution.new(
  	  user_id: user_id, 
  	  challenge_id: challenge_id, 
  	  method_string: method_string, 
  	  success: false,
      language: language
  	)

    timeout_in_seconds = 10

    begin
      Timeout::timeout(timeout_in_seconds) do
        @solution.success = @solution.sql_success?
      end
    rescue Exception

    end
    
    #reset the connection - start
    if Rails.env.production?
      @connection = ActiveRecord::Base.establish_connection(
                  :adapter => "postgresql",
                  :host => "ec2-184-73-229-220.compute-1.amazonaws.com",
                  :database => "d29j3r0ipqeto1",
                  :username => "bwssgawwtckdsr",
                  :password => "ENV[SQL_DATABASE_PASSWORD]"
      )
    else
      @connection = ActiveRecord::Base.establish_connection(
                  :adapter => "postgresql",
                  :host => "localhost",
                  :database => "codechef_clone_development",
                  :username => "maxplomer",
                  :password => "ENV[SQL_DATABASE_PASSWORD]"
      )
    end
    #reset the connection - start
    
    if @solution.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @solution.errors.full_messages
      render :new
    end
  end
end
