class MainController < ApplicationController
  def root

  end

  def test
    @num = params[:num].to_i
    @ln = Array.new(@num)
    @ls = Array.new(@num)
    @fill = Array.new(@num,false)
  end

  def calculate
    @num = params[:num].to_i
    @ln = Array.new(@num)
    @ls = Array.new(@num)
    @fill = Array.new(@num,false)
    
    @invalid = false
    @max_n = nil
    @max_s = nil
    @num.times do |i|
      @ln[i] = params[:subject][:name][i]
      @ls[i] = params[:subject][:score][i]
      if @ln[i].blank? or @ls[i].blank?
        @invalid = true
        @fill[i] = true
      elsif @ls[i].to_i > @max_s.to_i then
        @max_n = @ln[i]
        @max_s = @ls[i]
      end
    end
    
    if @invalid then
      render 'test'
    else
      render 'result'
    end
  end
end
