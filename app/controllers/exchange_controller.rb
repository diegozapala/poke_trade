class ExchangeController < ApplicationController

  def index
    @trades = Trade.all.order(created_at: :desc)
  end

  def valid_exchange
    @first_team = build_team(params["first"])
    @second_team = build_team(params["second"])

    trade = Trade.new(first_team: @first_team, second_team: @second_team)

    if !@first_team.present? || !@second_team.present?
      flash.alert =  "Troca injusta =("
    elsif base_experience_compare(@first_team, @second_team) < 50
      flash.notice = "Troca justa =)"
      trade.is_valid = true
      trade.save
    else
      flash.alert =  "Troca injusta =("
      trade.is_valid = false
      trade.save
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def build_team(data)
    team = (1..6).map do |index|
      next unless data[index.to_s]["name"].present?

      {
        name: data[index.to_s]["name"],
        poke_img: data[index.to_s]["poke_img"],
        base_experience: data[index.to_s]["base_experience"]
      }
    end

    team.compact
  end

  def build_base_experience_sum(data)
    data.map{ |team| team[:base_experience].to_i }.sum
  end

  def base_experience_compare(first_team, second_team)
    first_base = build_base_experience_sum(first_team)
    second_base = build_base_experience_sum(second_team)

    (first_base - second_base).abs
  end

end
