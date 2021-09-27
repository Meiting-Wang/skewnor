# Stata 新命令：skewnor--生成 skew-normal 随机数

> 作者：王美庭  
> Email: wangmeiting92@gmail.com

## 一、引言

如果 $X \sim \mathcal{SN}(\xi,\omega,\alpha)$，我们就说 $X$ 服从 location $\xi$、scale $\omega$ 和 shape $\alpha$ 的 skew-normal 分布，此时随机变量 $X$ 的概率密度为

$$
f_{X}(x)=\frac{2}{\omega} \phi\left(\frac{x-\xi}{\omega}\right) \Phi\left[\alpha \cdot \left(\frac{x-\xi}{\omega}\right)\right],\quad x\in (-\infty,+\infty)
$$

其中 $\phi(\cdot)$ 和 $\Phi(\cdot)$ 分别为标准正态分布的概率密度与分布函数。虽然 Stata 中随机数生成函数已经很多，但仍然没有找到 skew-normal 分布的随机数生成函数，于是便诞生了这个命令。该命令具有以下特点：

- 可以依据用户设定的 location $\xi$、scale $\omega$ 和 shape $\alpha$ 参数生成对应的该分布的随机数（随机数生成过程参照 da Silva Ferreira et al. (2011)）；
- 可以计算模拟值和真实分布的 mean、standard deviation、skewness 和 kurtosis。以上值同时也会被展示在 Stata 界面上和储存在返回值 **r()** 中；
- 可以将模拟值的 kernel density 和真实值的 density 画在一张图上，以便用户查看模拟效果（该图同时也包含模拟值的 histogram）

值得注意的是，该命令仅能使用于 16.0 及以上版本的 Stata 软件中。

## 二、命令的安装

`skewnor`及本人其他命令的代码都托管于 GitHub 上，读者可随时下载安装这些命令。

你可以通过系统自带的`net`命令进行安装：

```stata
net install skewnor, from("https://raw.githubusercontent.com/Meiting-Wang/skewnor/main")
```

也可以通过我所写的命令 `wmt` 进行安装：

```stata
wmt install skewnor
```

> `wmt` 命令可以查询并安装所有我写过的命令。该命令本身可以通过 `net install wmt, from("https://raw.githubusercontent.com/Meiting-Wang/wmt/main")` 进行安装。更多细节参见 [Stata 新命令：wmt——查询并安装个人写的 Stata 新命令](https://mp.weixin.qq.com/s/P2V_6et9crS5GeNNfO-6xQ)。

## 三、语法与选项

**命令语法**：

```stata
 skewnor newvar [, options]
```

**选项（options）**：

- `location(real)`: 设定分布的 location 参数，应该填写一个实数，默认为 0
- `scale(real>0)`: 设定分布的 scale 参数，应该填写一个正实数，默认为 1
- `shape(real)`: 设定分布的 shape 参数，应该填写一个实数，默认为 0
- `seed(integer>=0)`: 设定生成随机数的种子数，应该填写大于等于 0 的整数
- `characteristics`: 让命令计算模拟值和真实分布的各项数字特征，包括 mean、standard deviation、skewness 和 kurtosis。以上这些值同时也会被展示在 Stata 界面上和储存在返回值 **r()** 中
- `graph`: 让命令将模拟值的 kernel density 和真实值的 density 画在一张图上，以便用户查看模拟效果（该图同时也包含模拟值的 histogram）

> 以上部分选项可以缩写，详情可以在安装命令后`help skewnor`。

## 四、实例

```stata
clear
set obs 10000

skewnor X1 //默认生成 SN(0,1,0) 的随机数，此时与 N(0,1) 等价
skewnor X2, location(0) scale(1) shape(10) //生成 SN(0,1,10) 的随机数
skewnor X3, location(0) scale(1) shape(10) seed(123456) //设置 seed
skewnor X4, location(0) scale(1) shape(10) seed(123456) ch //报告所生成随机数的数字特征，并将其储存在返回值 r() 中
skewnor X5, location(0) scale(1) shape(10) seed(123456) ch graph //将模拟的核密度和真实的密度函数进行作图
ret list //展示返回值
```

> 以上所有实例都可以在`help skewnor`中直接运行。
>
> ![](https://cdn.jsdelivr.net/gh/Meiting-Wang/pictures/picgo/picgo-20210927145135.png)

## 五、输出效果展示

**命令行：**

```stata
cls
clear
set obs 10000
skewnor X, location(0) scale(1) shape(10) seed(123456) ch graph
sum
```

**输出结果：**

```stata
. clear

. set obs 10000
Number of observations (_N) was 0, now 10,000.

. skewnor X, location(0) scale(1) shape(10) seed(123456) ch graph

Parameters:
     location = 0
        scale = 1
        shape = 10

Characteristics:
     mean_sim = 0.797138         mean_true = 0.793925
       sd_sim = 0.610035           sd_true = 0.608016
       sk_sim = 0.927187           sk_true = 0.955557
     kurt_sim = 3.679771         kurt_true = 3.823244

. sum

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
           X |     10,000    .7971382    .6100349  -.2813204   3.949564
```

![](https://cdn.jsdelivr.net/gh/Meiting-Wang/pictures/picgo/picgo-20210927145703.png)

## 参考文献
- Da Silva Ferreira, Clécio, Heleno Bolfarine, and Víctor H. Lachos. 2011. "Skew scale mixtures of normal distributions: Properties and estimation." *Statistical Methodology* 8(2): 154-171.

> 点击【阅读原文】可进入该命令的 github 项目。
