//= require sparkline/jquery.sparkline
//= require sparkline/sparkline-init
//= require easypiechart/jquery.easypiechart

$(function() {
	$.ajax({
		url: '/manage/counts',
		type: 'GET',
		dataType: 'JSON',
		success: function(res) {
			$("#u-count").text(res.u_count);
			$("#m-count").text(res.m_count);
			$("#pt-count").text(res.pt_count);
			$("#p-count").text(res.p_count);
			$("#t-a-count").text(res.t_a_count);
			$("#t-v-count").text(res.t_v_count);
		}
	})

	$.ajax({
		url: '/manage/total_count',
		type: 'GET',
		dataType: 'JSON',
		success: function(res) {
			$("#m-t-v-count").text(res.m_t_v_count);
			$("#m-v-count").text(res.m_v_count);
			$("#m-d-count").text(res.m_d_count);
			$("#p-t-v-count").text(res.p_t_v_count);
			$("#p-v-count").text(res.p_v_count);
			$("#v-total").text(res.total_viewers_count);

			var total = res.p_v_count + res.m_v_count,
				pPercent = ((res.p_v_count / total) * 100).toFixed(1),
				mPercent = ((res.m_v_count / total) * 100).toFixed(1);
			$("#p-v-count-percent").attr("data-percent", pPercent);
			$("#m-v-count-percent").attr("data-percent", mPercent);
			$("#p-v-count-percent-v").text(pPercent + "%");
			$("#m-v-count-percent-v").text(mPercent + "%");

			$('.chart').easyPieChart({
				//your configuration goes here
			});
		}
	})
})
