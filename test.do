* 生成示例面板数据
clear all
cls
set obs 10000
egen id = fill(1 2) //升序等差为1的数据序列
expand 10
bysort id: gen year = _n + 2000
xtset id year
save temp,replace

* 普通使用
cls
use temp, clear
skewnor X1 //默认生成 SN(0,1,0) 的随机数，此时与 N(0,1) 等价
skewnor X2, location(0) scale(1) shape(10) //生成 SN(0,1,10) 的随机数
skewnor X3, location(0) scale(1) shape(10) seed(123456) //设置 seed
skewnor X4, location(0) scale(1) shape(10) seed(123456) ch //报告所生成随机数的数字特征，并将其储存在返回值 r() 中
skewnor X5, location(0) scale(1) shape(10) seed(123456) ch graph //将模拟的核密度和真实的密度函数进行作图
ret list //展示返回值

* 附加 if 或 in 语句
cls
use temp, clear
skewnor X, seed(123456)
skewnor X1 if id==2, seed(123456)
skewnor X2 in 1/15, seed(123456)
skewnor X3 if id==2 in 1/15, seed(123456)
skewnor X4 in 1/5000, location(0) scale(1) shape(10) seed(123456) graph

* 使用 by 或 bysort 选项
cls
use temp, clear
skewnor X, seed(123456)
bysort id (year): skewnor X1 if _n==1, seed(123456)
bysort id (year): skewnor X2 if _n==2, seed(123456)
bysort id (year): skewnor X3 if _n<=2, seed(123456)
bysort id (year): skewnor X4 if _n==1, location(0) scale(1) shape(10) seed(123456) graph
bysort id (year): skewnor X5 if _n<=2, location(0) scale(1) shape(10) seed(123456) graph

* 删除临时数据
erase temp.dta
