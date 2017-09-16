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
			$("#a-count").text(res.a_count);
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

			var total = res.m_v_count + res.p_v_count,
				mPercent = (res.m_v_count / total).toFixed(2) * 100,
			    pPercent = (res.p_v_count / total).toFixed(2) * 100;
			$("#v-total").text(total);
			$("#p-v-count-percent").attr("data-percent", mPercent);
			$("#m-v-count-percent").attr("data-percent", pPercent);
			$("#p-v-count-percent-v").text(mPercent + "%");
			$("#m-v-count-percent-v").text(pPercent + "%");

			$('.chart').easyPieChart({
				//your configuration goes here
			});
		}
	})
})
