/*global $*/
$("#programs_area").html("<%= j(render partial: 'admins/programs/index', locals: { programs: @programs }) %>")
