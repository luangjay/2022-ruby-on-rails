class MainController < ApplicationController
  # ------------ ADD PROCESS ------------ #
  def init_add
    @num = params[:num].to_i
    @ln = Array.new(@num)
    @ls = Array.new(@num)
    @fill = Array.new(@num,false)
  end

  def add
    init_add
    if params[:op]=='add'
      render 'add'
    elsif params[:op]=='validate'
      validate_add
    else
      render 'number'
    end
  end

  def validate_add
    @valid = true

    @num.times do |i|
      @ln[i] = params[:subject][:name][i]
      @ls[i] = params[:subject][:score][i]
      if @ln[i].blank? or @ls[i].blank?
        @valid = false
        @fill[i] = true
      end
    end

    if @valid then
      update_add
    else
      render 'add'
    end
  end

  def update_add
    @num.times do |i|
      @g = Grade.where(name: @ln[i]).first
      if @g.blank? then
        @g = Grade.new
      end
      
      @g.name = @ln[i]
      @g.score = @ls[i]

      if @g.save then end
    end

    index
    redirect_to '/'
  end

  # ------------ EDIT PROCESS ------------ #
  def edit
    @g = Grade.find(params[:id])
    @fill = false
    if params[:op]=='validate'
      validate_edit
    else
      render 'edit'
    end
  end

  def validate_edit
    @name = params[:name]
    @score = params[:score]
    @valid = !@name.blank? && !@name.blank?
    if @valid
      update_edit
    else
      @fill = true
      render 'edit'
    end
  end

  def update_edit
    @g.name = @name
    @g.score = @score

    if @g.save then end
    index
    redirect_to '/'
  end

  # ------------ DELETE PROCESS ------------ #
  def delete
    @g = Grade.find(params[:id])
    @g.destroy
    index
    redirect_to '/'
  end

  # ------------ DELETE_ALL PROCESS ------------ #
  def delete_all
    Grade.destroy_all
    index
    redirect_to '/'
  end

  # ------------ INDEX ------------ #
  def index
    @lg = Grade.all
    @max_g = Grade.where(score: @lg.maximum(:score)).first
  end

end
