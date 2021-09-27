{smcl}
{right:Created time: Sep 26, 2021}
{* -----------------------------title------------------------------------ *}{...}
{p 0 18 2}
{bf:[W-17] skewnor} {hline 2} To generate skew-normal(SN) random numbers. You can view the source code in {browse "https://github.com/Meiting-Wang/skewnor":github}.


{* -----------------------------Syntax------------------------------------ *}{...}
{title:Syntax}

{p 8 8 2}
{cmd:skewnor} {newvar} [, {it:{help skewnor##Options:options}}]


{* -----------------------------Contents------------------------------------ *}{...}
{title:Contents}

{p 4 4 2}
{help skewnor##Description:Description}{break}
{help skewnor##Options:Options}{break}
{help skewnor##Examples:Examples}{break}
{help skewnor##Author:Author}{break}
{help skewnor##Reference:Reference}


{* -----------------------------Description------------------------------------ *}{...}
{marker Description}{title:Description}

{p 4 4 2}
{cmd:skewnor} can generate skew-normal random numbers with the parameters of location, scale, and shape(the random number generation process mainly refers to {help skewnor##Ferreira:da Silva Ferreira et al.(2011)}).

{p 4 4 2}
In addition, {cmd:skewnor} can calculate simulated and true characteristics for the random variable with the option {opt characteristics}. The characteristics calculated include mean, standard deviation, skewness, and kurtosis.

{p 4 4 2}
If you choose to calculate characteristics for the random variable, the values above will also be stored in the return value {bf:r()} for later use.

{p 4 4 2}
We also provide option {opt graph}, which allows us to plot the simulated and true probability densities for comparison.

{p 4 4 2}
It is worth noting that this command can only be used in version 16.0 or later.


{* -----------------------------Options------------------------------------ *}{...}
{marker Options}{title:Options}

{synoptset 20}{...}
{synopthdr}
{synoptline}
{synopt :{opt l:ocation(real)}}Specify the location parameter, which should be a real number. 0 as the default.{p_end}
{synopt :{opt sc:ale(real>0)}}Specify the scale parameter, which should be a positive real number. 1 as the default.{p_end}
{synopt :{opt sh:ape(real)}}Specify the shape parameter, which should be a real number. 0 as the default.{p_end}
{synopt :{opt seed(integer>=0)}}Set the seed for the random number generation process, which should be a nonnegative integer.{p_end}
{synopt :{opt ch:aracteristics}}Calculate simulated and true characteristics for the random variable, which include mean, standard deviation, skewness, and kurtosis. The values above will also be stored in {bf:r()}.{p_end}
{synopt :{opt graph}}Generate a graph with histogram and simulated and true probability densities for the random variable.{p_end}
{synoptline}


{* -----------------------------Examples------------------------------------ *}{...}
{marker Examples}{title:Examples}

{p 4 4 2}Setup{p_end}
{p 8 10 2}. {stata clear}{p_end}
{p 8 10 2}. {stata set obs 10000}{p_end}

{p 4 4 2}Generate the random number of {it:SN}(0,1,0) by default, which is equivalent to the standard normal distribution.{p_end}
{p 8 10 2}. {stata skewnor X1}{p_end}

{p 4 4 2}Generate the random number of {it:SN}(0,1,10){p_end}
{p 8 10 2}. {stata skewnor X2, location(0) scale(1) shape(10)}{p_end}

{p 4 4 2}Set the number of seeds so that the results can be reproduced later{p_end}
{p 8 10 2}. {stata skewnor X3, location(0) scale(1) shape(10) seed(123456)}{p_end}

{p 4 4 2}Calculate simulated and true characteristics for the random variable{p_end}
{p 8 10 2}. {stata skewnor X4, location(0) scale(1) shape(10) seed(123456) ch}{p_end}

{p 4 4 2}Generate a graph with histogram and simulated and true probability densities for the random variable.{p_end}
{p 8 10 2}. {stata skewnor X5, location(0) scale(1) shape(10) seed(123456) ch graph}{p_end}

{p 4 4 2}View return values in {bf:r()}{p_end}
{p 8 10 2}. {stata return list}{p_end}


{* -----------------------------Author------------------------------------ *}{...}
{marker Author}{title:Author}

{p 4 4 2}
Meiting Wang{break}
Institute for Economic and Social Research, Jinan University{break}
Guangzhou, China{break}
wangmeiting92@gmail.com


{* -----------------------------Also see------------------------------------ *}{...}
{marker Reference}{title:Reference}

{p 4 6 2}
{marker Ferreira}Da Silva Ferreira, Clécio, Heleno Bolfarine, and Víctor H. Lachos. 2011. "Skew scale mixtures of normal distributions: Properties and estimation." {it:Statistical Methodology} 8(2): 154-171.

