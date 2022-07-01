function Destroy(options) {
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

  module.destroy = function () {
    $(".delete-course").click(function () {
      const course_id = $(this)
        .closest(".single-course-section")
        .attr("course_id");
      $.ajax({
        url: module.settings.api.course,
        headers: {
          api_token: module.settings.data.api_token,
        },
        type: "DELETE",
        data: { course_id: course_id },
        dataType: "json",
        beforeSend:function(){
          return confirm("Are you sure?");
        },
        success: function (res) {
          $.notify.defaults({globalPosition: 'right'});
          if (res.code == 200) {
            window.location.href = "/my_courses";
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

  module.destroy_outer = function () {
    $(document).on("click", ".delete_course", function (event) {
      event.preventDefault();
      const course_id = $(this).attr("course_id");
      $.ajax({
        url: module.settings.api.course,
        headers: {
          api_token: module.settings.data.api_token,
        },
        type: "DELETE",
        data: { course_id: course_id },
        dataType: "json",
        beforeSend:function(){
          return confirm("Are you sure?");
        },
        success: function (res) {
          $.notify.defaults({globalPosition: 'right'});
          if (res.code == 200) {
            var data = { courses: res.data };
            var template = _.template( $("#template_course").text() );
            
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

  module.init = function () {
    module.destroy();
    module.destroy_outer();
  };
}

$(document).ready(function () {
  destroy = new Destroy();
  destroy.init();
});
