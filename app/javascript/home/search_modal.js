$(document).ready(function () {

  $("#home .team .team_box .item").click(function(e) {
    openModal($(this));
  });

  $(".search_modal").click(function(e) {
    e.stopPropagation();
    closeModal();
  });

  $(".search_box").click(function(e) {
    e.stopPropagation();
  });

  $(".search_field").keyup(function(e) {
    $(".search_modal .error").hide();
    emailValue = $(this).val().replace(/\s/g,'').toLowerCase();
    $(this).val(emailValue);
  });

  $(".search_btn").click(function(e) {
    url = "/get_poke"
    poke_name = $(this).parent(".search_box").children(".search_field").val();
    elem = $(this).parent(".search_box").parent(".search_modal").parent(".item")

    $.post( url, { poke_name: poke_name })
      .done(function( data ) {
      if(data.status === "OK"){
        insertPoke(data, elem);
      } else {
        pokeNotFound();
      }
    });
  });

});

function openModal(elem) {
  elem.children(".search_modal").show();
}

function closeModal() {
  $(".search_modal").hide();
}

function insertPoke(data, elem) {
  $("#home .exchange_box").removeClass("valid").removeClass("invalid")
  elem.removeClass("empty")
  elem.children(".poke_name").val(data.name)
  elem.children(".poke_img").val(data.url_img)
  elem.children(".base_experience").val(data.base_experience)
  elem.children(".content").html('<div class="poke_name">'+ data.name +'</div>' +
                                 '<div class="poke_img_box"><img src="'+ data.url_img +'"class="poke_img"></div>'+
                                 '<div class="base_experience">'+ data.base_experience +'</div>')
  closeModal();
}

function pokeNotFound() {
  $(".search_modal .error").show();
}
