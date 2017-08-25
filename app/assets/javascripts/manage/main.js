// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
	$.ajax({
		url: '/manage/counts',
		type: 'GET',
		dataType: 'JSON',
		success: function(res) {
			$("#u-count").text(res.u_count);
			$("#v-count").text(res.v_count);
			$("#a-count").text(res.a_count);
			$("#p-count").text(res.p_count);
		}
	})
})
