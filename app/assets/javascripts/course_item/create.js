function CourseItem(options) {
  var module = this;
  var defaults = {
    api: {
      course_item: "/api/v1/courses/course_item",
    },
    data: {
      api_token: Cookies.get("api_token"),
    },
  };
  module.settings = $.extend({}, defaults, options);

  $(".add_new_course_btn").on("click", function () {
    $(".form_create_course_item").show();
  });

  $(".close_icon").on("click", function () {
    $(".form_create_course_item").hide();
  });

  module.add_course_item = function (e) {
    const formData = new FormData();
    $("#video").bind("change", function () {
      var formData = new FormData();
      formData.append('Video', $(this).files);
      console.log(formData);
    });
    return
    $(document).on("click", ".create_course", function (e) {
      // e.preventDefault();
      // e.stopPropagation();
      const title = $(this)
        .closest(".form_create_course_item")
        .find("#inputTitle")
        .val();
      const desc = $(this)
        .closest(".form_create_course_item")
        .find("#inputDescription")
        .val();
        $(this).closest(".form_create_course_item").find("#video").bind("change", function(){
          console.log(78439);
          // console.log(this.file);
        });
        // const video = $(this).closest(".form_create_course_item").find("#video");

        // console.log(video);

        return

      $.ajax({
        url: module.settings.api.course_item,
        headers: {
          api_token: module.settings.data.api_token,
        },
        type: "POST",
        data: { title: title, desc: desc, video: formData },
        dataType: "json",
        success: function (res) {
          console.log(res);
          $.notify.defaults({ globalPosition: "right" });
          if (res.code == 200) {
            var data = { cart: [] };
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
  };

  module.delete_cart_item = function () {
    $(document).on("click", ".delete_cart_item", function (e) {
      const cart_item_id = $(this).attr("cart_item_id");

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
  };

  module.init = function () {
    module.add_course_item();
    module.delete_cart_item();
  };
}

$(document).ready(function () {
  courseItem = new CourseItem();
  courseItem.init();
});
