/*global $*/
$("#comments_area").html("<%= j(render partial: 'members/reviews/show_review', locals: { program: @program, member: @member, reviews: @reviews }) %>")
$("textarea").val('')
