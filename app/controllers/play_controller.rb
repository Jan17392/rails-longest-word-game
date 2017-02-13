require 'json'
require 'open-uri'
require 'rest-client'

class PlayController < ApplicationController
  def game

    @start_time = Time.now

    def generate_grid(grid_size)
      @array = []
      8.times do
        @array << ('a'..'z').to_a.sample
      end
    end

    generate_grid(8)

  end

  def score
    @attempt = params[:attempt];
    @time = Time.now() - params[:start_time].to_time
    @grid = params[:grid];
    @valid = 0;

      if @attempt != ""
        @response = JSON.parse(RestClient.get("https://api-platform.systran.net/translation/text/translate?source=en&target=fr&key=0a17489f-154d-4fcb-b179-59f176e01393&input=#{@attempt}"))
        @grid = @grid.upcase.chars
        @attempt_array = @attempt.upcase.chars
        @attempt_array.each do |char|
          if @grid.include?(char)
            @grid.delete_at(@grid.index(char))
          else
            @valid += 1
          end
        end
        @translation = @response["outputs"][0]["output"]
        if @translation == @attempt && @valid.zero? #in_grid == []
          @translation = nil
          @score = 0
          @message = "not an english word"
        elsif @translation != @attempt && @valid.zero? #in_grid == []
          @score = @translation.length + (1 - @time / 100)
          @message = "well done"
        else
          @translation = nil
          @score = 0
          @message = "not in the grid"
        end
      else
        nil
      end
    end
end
