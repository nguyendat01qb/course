function Destroy(options) {
  var module = this;
  var defaults = {
    api: {
      blog: "/api/v1/blogs",
    },
    data: {
      api_token: Cookies.get("api_token"),
    },
  };
  module.settings = $.extend({}, defaults, options);

  module.destroy_blog = function () {
    $(document).on("click", ".delete_this_course", function (event) {
      event.preventDefault();
      const blog_id = $(this).closest(".post-content-detail").find('h2 a').attr("blog_id");

      $.ajax({
        url: module.settings.api.blog,
        headers: {
          api_token: module.settings.data.api_token,
        },
        type: "DELETE",
        data: { blog_id: blog_id },
        dataType: "json",
        beforeSend:function(){
          return confirm("Are you sure?");
        },
        success: function (res) {
          $.notify.defaults({globalPosition: 'right'});
          if (res.code == 200) {
            console.log(res);
            var data = { blogs: res.data };
            var template = _.template( $("#template_blog").text() );
            
            $("#list_blogs").html(template(data));

            $(".blog-box").hide();
            
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
    module.destroy_blog();
  };
}

$(document).ready(function () {
  destroy = new Destroy();
  destroy.init();
});
