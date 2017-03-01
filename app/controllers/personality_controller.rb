class PersonalityController < ApplicationController
    
    def start
        
    end
    
    def input
        @personality = Personality.new
    end
    
    def confirm
      
        @personality = Personality.new(params[:personality])
        @@mytext = params[:personality][:ans1] + params[:personality][:ans2] + params[:personality][:ans3]
        
        if @personality.valid?
          redirect_to result_path
        else
          render 'input'
        end
        
    end
    
    def result
        
        require 'watson-api-client'
        service = WatsonAPIClient::PersonalityInsights.new(:user => "b8b6f056-9a23-4fbe-a68c-df941c75fc19",
                                                           :password => "0LBxDttsDk3Q",
                                                           :verify_ssl => OpenSSL::SSL::VERIFY_NONE)
        
        text_data = @@mytext
        
        input_data = service.profile(
          'version'          => "2016-10-20",
          'Content-Type'     => "text/plain",
          'Accept'           => "application/json",
          'Accept-Language'  => "ja",
          'Content-Language' => "ja",
          'body'             => text_data)
        
        result_data = JSON.parse(input_data.body)
        @insight_data = result_data
        
        #-- Personality --
        
        @insight_personality = {}
        
        result_data["personality"].each do |insights|
          key = insights["trait_id"]
          val = insights["percentile"]
          @insight_personality.store(key,(val*100).floor)
        end
        
        #-- Needs --
        
        @insight_needs = {}
        
        result_data["needs"].each do |insights|
          key = insights["trait_id"]
          val = insights["percentile"]
          @insight_needs.store(key,(val*100).floor)
        end
        
        #-- Values --
        
        @insight_values = {}
        
        result_data["values"].each do |insights|
          key = insights["trait_id"]
          val = insights["percentile"]
          @insight_values.store(key,(val*100).floor)
        end
        
    end
    
end
