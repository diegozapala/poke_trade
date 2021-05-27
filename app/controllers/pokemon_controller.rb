class PokemonController < ApplicationController

  def get_poke
    if poke_response_ok?
      name = params[:poke_name]
      base_experience = poke_response_poke["base_experience"]

      response = {name: name, base_experience: base_experience, url_img: get_poke_img, status: "OK"}
    else
      response = {status: "NOK"}
    end

    json_response(response)
  end

  private

  def get_url
    @get_url ||= PokeApiService.get_url(params[:poke_name])
  end

  def get_poke_img
    @get_poke_img ||= PokeApiService.get_poke_img(poke_response_poke["id"])
  end

  def poke_api_request_poke
    @poke_api_request_poke ||= PokeApiService.new(api_url: get_url)
  end

  def poke_response_ok?
    poke_api_request_poke.response_ok?
  end

  def poke_response_poke
    poke_api_request_poke.response_body
  end

end
