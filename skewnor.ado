* Description: To generate skew-normal random numbers.
* Author: Meiting Wang, Ph.D. Candidate, Institute for Economic and Social Research, Jinan University
* Email: wangmeiting92@gmail.com
* Created on Sep 26, 2021
* Update on Oct 9, 2021



program define skewnor, rclass by(onecall)
version 16.0

syntax newvarname [if] [in] [, Location(real 0) SCale(numlist max=1 >0) SHape(real 0) seed(numlist max=1 integer) CHaracteristics graph]
/****编程注意事项：
-如果使用了 by 选项，则进入这里之前数据一定已经处于 sort byvars 的状态，于是我们在后面的编程中可以使用这一结果。
****/

*----------------------- 前期处理 -----------------------------
*- 默认值设置
if "`scale'" == "" {
	local scale = 1
}

*- 参数输出
#delimit ;
dis _n as result "{text:Parameters:}" _n
	_col(6) "{text:location = }" `location' _n
	_col(6) _s(3) "{text:scale = }" `scale' _n
	_col(6) _s(3) "{text:shape = }" `shape'
;
#delimit cr


*------------------------- 主程序 --------------------------------
*- 生成 SN random number
tempvar T0 T1
if "`seed'" != "" {
	set seed `seed'
}
local delta = `shape' / sqrt(1+`shape'^2)
if _by() { //有 by 或 bysort 前缀的情况
	qui by `_byvars': gen `T0' = rnormal() `if' `in'
	qui by `_byvars': gen `T1' = rnormal() `if' `in'
	qui by `_byvars': gen `varlist' = `location' + `scale'*(`delta'*abs(`T0') + sqrt(1-`delta'^2)*`T1') `if' `in'
}
else { //无 by 或 bysort 前缀的情况
	qui gen `T0' = rnormal() `if' `in'
	qui gen `T1' = rnormal() `if' `in'
	qui gen `varlist' = `location' + `scale'*(`delta'*abs(`T0') + sqrt(1-`delta'^2)*`T1') `if' `in'
}
drop `T0' `T1'


*--------------------------- 附加选项 ----------------------------
*- 依据选项输出 characteristics 及将其储存在返回值r()中
if "`characteristics'" != "" {
	*-- simulation circumstance
	qui sum `varlist', d
	local mean_sim = r(mean)
	local sd_sim = r(sd)
	local sk_sim = r(skewness)
	local kurt_sim = r(kurtosis)

	*-- true circumstance
	local c = sqrt(2/_pi)
	local mean_true = `location' + `c'*`scale'*`delta'
	local sd_true = `scale'*sqrt(1-`c'^2*`delta'^2)
	local sk_true = (4-_pi)/2 * (`scale'*`delta'*`c'/`sd_true')^3
	local kurt_true = 3 + 2*(_pi-3)*(`scale'*`delta'*`c'/`sd_true')^4

	*-- 将结果输出至界面
	#delimit ;
	dis _n as result "{text:Characteristics:}" _n
		_col(6) "{text:mean_sim = }" %7.6f `mean_sim' _col(34) "{text:mean_true = }" %7.6f `mean_true' _n
		_col(6) _s(2) "{text:sd_sim = }" %7.6f `sd_sim' _col(34) _s(2) "{text:sd_true = }" %7.6f `sd_true' _n
		_col(6) _s(2) "{text:sk_sim = }" %7.6f `sk_sim' _col(34) _s(2) "{text:sk_true = }" %7.6f `sk_true' _n
		_col(6) "{text:kurt_sim = }" %7.6f `kurt_sim' _col(34) "{text:kurt_true = }" %7.6f `kurt_true'
	;
	#delimit cr

	*-- 将以上结果储存于返回值中
	ret scalar mean_sim = `mean_sim'
	ret scalar sd_sim = `sd_sim'
	ret scalar sk_sim = `sk_sim'
	ret scalar kurt_sim = `kurt_sim'
	ret scalar mean_true = `mean_true'
	ret scalar sd_true = `sd_true'
	ret scalar sk_true = `sk_true'
	ret scalar kurt_true = `kurt_true'
}


*- 依据选项进行作图
if "`graph'" != "" {
	qui sum `varlist'
	local min = r(min)
	local max = r(max)

	#delimit ;
	twoway histogram `varlist' ||
		kdensity `varlist', lc(blue) || 
		function y = 2/`scale' * normalden((x-`location')/`scale') * normal(`shape'*(x-`location')/`scale'), range(`min' `max') lc(red) 
		xtitle("`varlist'")
		ytitle("Density")
		title("{it:SN}(`location',`scale',`shape')")
		legend(order(2 "simulated density" 3 "true density") r(1))
		graphregion(c(white));
	#delimit cr
}

end
