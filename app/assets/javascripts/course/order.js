function Order(options) {
  var module = this;
  var defaults = {
    api: {
      order: "/api/v1/orders",
    },
    data: {
      api_token: Cookies.get("api_token"),
    },
  };
  module.settings = $.extend({}, defaults, options);

  module.add_order = function () {
    $(document).on("click", ".add_order", function (e) {
      const cart_id = $(this).attr("cart_id");

      $.ajax({
        url: module.settings.api.order,
        headers: {
          api_token: module.settings.data.api_token,
        },
        type: "POST",
        data: { cart_id: cart_id },
        dataType: "json",
        success: function (res) {
          $.notify.defaults({ globalPosition: "right" });
          if (res.code == 200) {
            var data = { courses: res.data };
              var template = _.template($("#template_course").text());

              $("#list_courses").html(template(data));

              $(".list_course").hide();
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
          if (res.code == 200) {
            console.log(res);
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
    module.add_order();
    module.delete_cart_item();
  };
}

$(document).ready(function () {
  order = new Order();
  order.init();
});
