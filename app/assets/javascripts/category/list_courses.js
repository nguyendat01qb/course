function ListCourses(options) {
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

  module.list_courses = function () {
    $(".category_type").click(function () {
      const category_id = $(this).attr("category_id");

      $.ajax({
        url: module.settings.api.course,
        headers: {
          api_token: module.settings.data.api_token,
        },
        type: "GET",
        data: { value_search: '', category_id: category_id },
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
    });
  };

  module.init = function () {
    module.list_courses();
  };
}

$(document).ready(function () {
  listCourses = new ListCourses();
  listCourses.init();
});
