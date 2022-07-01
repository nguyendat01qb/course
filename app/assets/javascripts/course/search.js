function Search(options) {
  var module = this;
  var defaults = {
    api: {
      course: "/api/v1/courses",
    },
    data: {
      api_token: Cookies.get("api_token"),
    },
  };
  module.settings = $.extend({}, defaults, options);

  module.search = function () {
    $(document).on("keypress", "#search_course", function (e) {
      if (e.keyCode === 13) {
        const value_search = $(this).val();
        $.ajax({
          url: module.settings.api.course,
          headers: {
            api_token: module.settings.data.api_token,
          },
          type: "GET",
          data: { value_search: value_search, category_id: '' },
          dataType: "json",
          success: function (res) {
            if (res.code == 200) {
              var data = { courses: res.data };
              var template = _.template($("#template_course").text());

              $("#list_courses").html(template(data));

              $(".list_course").hide();
            } else {
              console.log(res);
            }
          },
          error: function (e) {
            $.notify(e, "error");
          },
        });
      }
    });
  };

  module.init = function () {
    module.search();
  };
}

$(document).ready(function () {
  search = new Search();
  search.init();
});
