function Cart(options) {
  var module = this;
  var defaults = {
    api: {
      cart: "/api/v1/carts",
    },
    data: {
      api_token: Cookies.get("api_token"),
    },
  };
  module.settings = $.extend({}, defaults, options);

  module.add_to_cart = function () {
    $(".add_to_cart").click(function () {
      const course_id = $(this).attr("course_id");

      $.ajax({
        url: module.settings.api.cart,
        headers: {
          api_token: module.settings.data.api_token,
        },
        type: "POST",
        data: { course_id: course_id },
        dataType: "json",
        success: function (res) {
          $.notify.defaults({ globalPosition: "right" });
          if (res.code == 200) {
            $.notify(res.message, "success");
          } else {
            $.notify(res.message, "error");
          }
        },
        error: function (e) {
          $.notify(e, "error");
        },
      });
    });
  };

  module.delete_cart_item = function(){
    $(document).on("click", ".delete_cart_item", function (e) {
      const cart_item_id = $(this).attr('cart_item_id');

      $.ajax({
        url: module.settings.api.cart,
        headers: {
          api_token: module.settings.data.api_token,
        },
        type: "DELETE",
        data: { cart_item_id: cart_item_id },
        dataType: "json",
        success: function (res) {
          $.notify.defaults({ globalPosition: "right" });
          console.log(res);
          if (res.code == 200) {
            var data = { cart: res.data };
              var template = _.template($("#template_carts").text());

              $("#list_carts").html(template(data));

              $(".list_carts").hide();
            $.notify(res.message, "success");
          } else {
            $.notify(res.message, "error");
          }
        },
        error: function (e) {
          $.notify(e, "error");
        },
      });
    });
  }

  module.init = function () {
    module.add_to_cart();
    module.delete_cart_item();
  };
}

$(document).ready(function () {
  cart = new Cart();
  cart.init();
});
