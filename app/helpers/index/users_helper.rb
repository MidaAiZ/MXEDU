module Index::UsersHelper
	def get_grades
		y = Time.now.year
		ys = []
		6.times do |i|
		  ys.push [y.to_s + '级', y]
		  y -= 1
		end
		ys
	end
end
