pr drop _all
cls
clear
set obs 10000

skewnor X1 //默认生成 SN(0,1,0) 的随机数，此时与 N(0,1) 等价
skewnor X2, location(0) scale(1) shape(10) //生成 SN(0,1,10) 的随机数
skewnor X3, location(0) scale(1) shape(10) seed(123456) //设置 seed
skewnor X4, location(0) scale(1) shape(10) seed(123456) ch //报告所生成随机数的数字特征，并将其储存在返回值 r() 中
skewnor X5, location(0) scale(1) shape(10) seed(123456) ch graph //将模拟的核密度和真实的密度函数进行作图
ret list //展示返回值
