function Review(options) {
  var module = this;
  var defaults = {
    api: {
      review: "/api/v1/reviews",
    },
    data: {
      api_token: Cookies.get("api_token"),
    },
  };
  module.settings = $.extend({}, defaults, options);

  var score = 1;
  $("#user_stars > img").click(function () {
    score = $(this).attr("alt");
  });

  $(".course-review-non-login").click(function () {
    $.notify("Please login!", "warning");
  });

  module.addReview = function () {
    $(document).on("click", ".course-review-form", function (event) {
      event.preventDefault();

      const review_text = $(this).siblings("#review-text");
      const course_id = $(this)
        .closest(".course-reviews-inner")
        .attr("course_id");

      $.ajax({
        url: module.settings.api.review,
        headers: {
          api_token: module.settings.data.api_token,
        },
        type: "POST",
        data: {
          rate: score,
          comment: review_text.val(),
          course_id: course_id,
        },
        dataType: "json",
        success: function (res) {
          $.notify.defaults({ globalPosition: "right" });
          if (res.code == 200) {
            review_text.val("");
            $('.list_review').hide();

            var data = { reviews: res.data };
            var template = _.template($("#template_review").text());

            $("#list_reviews").html(template(data));

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

  module.showInput = function () {
    $(document).on("click", ".reply_comment", function (event) {
      event.preventDefault();
      const list_btn = $(this).closest(".comment_event");
      list_btn.hide();
      const input = list_btn.siblings(".input_reply");
      input.show();
    });
  };

  module.reply = function () {
    $(document).on("keypress", ".input_reply", function (e) {
      if (e.keyCode === 13) {
        const course_id = $(this)
          .closest(".course-reviews-inner")
          .attr("course_id");
        const review_id = $(this).closest("li").attr("review_id");
        const comment = $(this);

        $.ajax({
          url: module.settings.api.review,
          headers: {
            api_token: module.settings.data.api_token,
          },
          type: "POST",
          data: {
            comment: comment.val(),
            course_id: course_id,
            review_id: review_id,
          },
          dataType: "json",
          success: function (res) {
            $.notify.defaults({ globalPosition: "right" });
            if (res.code == 200) {
              comment.val("");
              $(".list_review").hide();

              var data = { reviews: res.data };
              var template = _.template($("#template_review").text());

              $("#list_reviews").html(template(data));

              $.notify(res.message, "success");
            } else {
              $.notify(res.message, "error");
            }
          },
          error: function (e) {
            $.notify(e, "error");
          },
        });
      }
    });
  };

  module.deleteReview = function () {
    $(document).on("click", ".delete_comment", function (event) {
      const review_id = $(this).closest("li").attr("review_id");
      const course_id = $(this).closest("section").attr("course_id");

      $.ajax({
        url: module.settings.api.review,
        headers: {
          api_token: module.settings.data.api_token,
        },
        type: "DELETE",
        data: { review_id: review_id, course_id: course_id },
        dataType: "json",
        success: function (res) {
          $.notify.defaults({ globalPosition: "right" });
          if (res.code == 200) {
            $(".list_review").hide();
            var data = { reviews: res.data };
            var template = _.template($("#template_review").text());

            $("#list_reviews").html(template(data));
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
    module.addReview();
    module.showInput();
    module.reply();
    module.deleteReview();
  };
}

$(document).ready(function () {
  review = new Review();
  review.init();
});
