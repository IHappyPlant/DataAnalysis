# Анализ данных

## Навигация

* [Лабораторная работа 1: Средства предварительной обработки данных](#средства-предварительной-обработки-данных)
* [Лабораторная работа 2: Линейные модели регрессии](#линейные-модели-регрессии)
* [Лабораторная работа 3: Дисперсионный анализ](#дисперсионный-анализ)
* [Лабораторная работа 4: Канонический анализ](#канонический-анализ)

## Средства предварительной обработки данных

В данной работе проводится анализ выборки stackloss:  

```R
> stackloss
   Air.Flow Water.Temp Acid.Conc. stack.loss
1        80         27         89         42
2        80         27         88         37
3        75         25         90         37
4        62         24         87         28
5        62         22         87         18
6        62         23         87         18
7        62         24         93         19
8        62         24         93         20
9        58         23         87         15
10       58         18         80         14
11       58         18         89         14
12       58         17         88         13
13       58         18         82         11
14       58         19         93         12
15       50         18         89          8
16       50         18         86          7
17       50         19         72          8
18       50         19         79          8
19       50         20         80          9
20       56         20         82         15
21       70         20         91         15
```

Суммарная информация о выборке:  

```R
> data <- stackloss
> stat.desc(data)
				 Air.Flow  Water.Temp   Acid.Conc.  stack.loss
nbr.val        21.0000000  21.0000000 2.100000e+01  21.0000000
nbr.null        0.0000000   0.0000000 0.000000e+00   0.0000000
nbr.na          0.0000000   0.0000000 0.000000e+00   0.0000000
min            50.0000000  17.0000000 7.200000e+01   7.0000000
max            80.0000000  27.0000000 9.300000e+01  42.0000000
range          30.0000000  10.0000000 2.100000e+01  35.0000000
sum          1269.0000000 443.0000000 1.812000e+03 368.0000000
median         58.0000000  20.0000000 8.700000e+01  15.0000000
mean           60.4285714  21.0952381 8.628571e+01  17.5238095
SE.mean         2.0006802   0.6897369 1.169336e+00   2.2196300
CI.mean.0.95    4.1733457   1.4387659 2.439192e+00   4.6300671
var            84.0571429   9.9904762 2.871429e+01 103.4619048
std.dev         9.1682683   3.1607715 5.358571e+00  10.1716225
coef.var        0.1517208   0.1498334 6.210265e-02   0.5804459

```

 Корреляционная матрица:  

```R
> cor(data)
		    Air.Flow Water.Temp Acid.Conc. stack.loss
Air.Flow   1.0000000  0.7818523  0.5001429  0.9196635
Water.Temp 0.7818523  1.0000000  0.3909395  0.8755044
Acid.Conc. 0.5001429  0.3909395  1.0000000  0.3998296
stack.loss 0.9196635  0.8755044  0.3998296  1.0000000
```

Корелляционная матрица показывает досттаочно сильную связь между переменными ```Air.Flow```,  ```Water.Temp``` и ```stack.loss```.  

Дальнейший анализ проводился по переменным ```Air.Flow``` и ```stack.loss```.  

### Тесты значимости среднего

Проведём тесты значимости среднего:  

```R
> t.test(data$Air.Flow, mu = mean(data$Air.Flow))

		One Sample t-test

data:  data$Air.Flow
t = 0, df = 20, p-value = 1
alternative hypothesis: true mean is not equal to 60.42857
95 percent confidence interval:
 56.25523 64.60192
sample estimates:
mean of x 
 60.42857 
```

Полученное значение для ```Air.Flow``` находится в пределах доверительного интервала, поэтому гипотеза о равенстве мат. ожидания выборочному среднему принимается.  

```R
> wilcox.test(
    data$Air.Flow,
    mu = median(data$Air.Flow),
    conf.int = TRUE
)

		Wilcoxon signed rank test with continuity correction

data:  data$Air.Flow
V = 74, p-value = 0.4394
alternative hypothesis: true location is not equal to 58
95 percent confidence interval:
 55.99999 68.00001
sample estimates:
(pseudo)median 
      61.99994
```

Значение, полученное в тесте Уилкокса, также находится внутри доверительного интервала.  



Проведём тесты для ```stack.loss```:  

```R
> t.test(data$stack.loss, mu = mean(data$stack.loss))

	One Sample t-test

data:  data$stack.loss
t = 0, df = 20, p-value = 1
alternative hypothesis: true mean is not equal to 17.52381
95 percent confidence interval:
 12.89374 22.15388
sample estimates:
mean of x 
 17.52381
```

Полученное значение среднего находится внутри доверительного интервала, следовательно, гипотеза принимается.  

```R
> wilcox.test(
    data$stack.loss,
    mu = median(data$stack.loss),
    conf.int = TRUE
)

	Wilcoxon signed rank test with continuity correction

data:  data$stack.loss
V = 92.5, p-value = 0.7768
alternative hypothesis: true location is not equal to 15
95 percent confidence interval:
 11.49998 24.00005
sample estimates:
(pseudo)median 
      15.99999 
```

Значение, полученное в тесте Уилкокса, также находится в пределах доверительного интервала.  



### Проверка гипотез нормальности

Проверим соответствие распределений переменных ```Air.Flow``` и ```stack.loss``` нормальному распределению.  

```R
> shapiro.test(data$Air.Flow)

	Shapiro-Wilk normality test

data:  data$Air.Flow
W = 0.86115, p-value = 0.006651
```

Для ```Air.Flow``` ```p.value = 0.006 < 0.05```, что означает отклонение гипотезы о нормальном распределении в пользу альтернативной (распределение не соответствует нормальному).  

```R
> ks.test(data$Air.Flow, "pnorm")

	One-sample Kolmogorov-Smirnov test

data:  data$Air.Flow
D = 1, p-value < 2.2e-16
alternative hypothesis: two-sided
```

Значение, полученное в тесте Колмогорова-Смирнова, подтверждает результат теста Шапиро.  



Проведём тесты для переменной ```stack.loss```:  

```R
> shapiro.test(data$stack.loss)

	Shapiro-Wilk normality test

data:  data$stack.loss
W = 0.82651, p-value = 0.001718
```

Для ```stack.loss``` ```p.value < 0.05```, что означает отклонение гипотезы о нормальном распределении в пользу альтернативной (распределение не соответствует нормальному).  

```R
> ks.test(data$stack.loss, "pnorm")

	One-sample Kolmogorov-Smirnov test

data:  data$stack.loss
D = 1, p-value < 2.2e-16
alternative hypothesis: two-sided
```

Значение, полученное в тесте Колмогорова-Смирнова, подтверждает результат теста Шапиро.  

### Визуализация данных

Визуализируем переменные ```Air.Flow``` и ```stack.loss```:  

![](https://github.com/IHappyPlant/Data_Analysis/blob/master/images/homework_1/hw1_air_flow_plot.png)

![](https://github.com/IHappyPlant/Data_Analysis/blob/master/images/homework_1/hw1_stack_loss_plot.png)



Сравним квантили выборки с квантилями нормального распределения:  

![](https://github.com/IHappyPlant/Data_Analysis/blob/master/images/homework_1/hw1_air_flow_qqnorm.png)

![](https://github.com/IHappyPlant/Data_Analysis/blob/master/images/homework_1/hw1_stack_loss_qqnorm.png)

Приведённые графики подтверждают, что распределения переменных не полностью соответствуют нормальному.  



Сравним плотность распределения переменных из выборки с доверительной полосой плотности нормального распределения .  

![](https://github.com/IHappyPlant/Data_Analysis/blob/master/images/homework_1/hw1_air_flow_density.png)

![](https://github.com/IHappyPlant/Data_Analysis/blob/master/images/homework_1/hw1_stack_loss_density.png)

Построим гистограммы для переменных ```Air.Flow``` и ```stack.loss```:  

![](https://github.com/IHappyPlant/Data_Analysis/blob/master/images/homework_1/air_flow_hist.png)

![](https://github.com/IHappyPlant/Data_Analysis/blob/master/images/homework_1/stack_loss_hist.png)

## Линейные модели регрессии

В данной работе строятся и анализируются различные линейные модели регрессии для выборки stackloss.  

Из данных лабораторной работы 1 следует, что в выборке stackloss наибольший коэффициент корреляции имеют переменные ```stack.loss``` и ```Air.Flow```.  

Будем считать переменную ```stack.loss``` зависимой, а остальные переменные - предикторными.  

### Парная регрессия

Проведём регрессионный анализ для переменных ```stack.loss``` и ```Air.Flow```.  

Построим график связи переменных:  

![](https://github.com/IHappyPlant/Data_Analysis/blob/master/images/homework_2/hw2_stack_loss_air_flow_plot.png)

На графике видна зависимость ```stack.loss``` от ```Air.Flow```.  

Построим модель линейной регрессии:  

```R
> data <- stackloss
> lm.rat1<-lm(formula=data$Air.Flow~data$stack.loss)
> summary(lm.rat1)

Call:
lm(formula = data$Air.Flow ~ data$stack.loss)

Residuals:
    Min      1Q  Median      3Q     Max 
-7.1128 -2.3365 -0.3365  1.1767 11.6635 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)     45.90229    1.63549   28.07  < 2e-16 ***
data$stack.loss  0.82895    0.08121   10.21 3.77e-09 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 3.694 on 19 degrees of freedom
Multiple R-squared:  0.8458,	Adjusted R-squared:  0.8377 
F-statistic: 104.2 on 1 and 19 DF,  p-value: 3.774e-09
```

Вероятность ```F-statistic ``` составляет ```3.774e-09```, что свидетельствует о значимости модели регрессии.  

Построим таблицу дисперсионного анализа:

```R
> anova(lm.rat1)

Analysis of Variance Table

Response: data$Air.Flow
                Df  Sum Sq Mean Sq F value    Pr(>F)    
data$stack.loss  1 1421.88 1421.88   104.2 3.774e-09 ***
Residuals       19  259.26   13.65
```

Вычислим доверительные области: 

```R
> CPI.df <- cbind(predict(lm.rat1,interval ="conf"), predict(lm.rat1,interval ="pred"))
> CPI.df <- CPI.df[,-4]
> colnames(CPI.df) <- c("Y_fit","CI_l","CI_u","PI_l","PI_u")
> head(CPI.df)

     Y_fit     CI_l     CI_u     PI_l     PI_u
1 80.71800 76.22876 85.20724 71.77760 89.65840
2 76.57327 72.85781 80.28873 67.99527 85.15128
3 76.57327 72.85781 80.28873 67.99527 85.15128
4 69.11276 66.65979 71.56574 61.00138 77.22415
5 60.82331 59.13420 62.51242 52.90936 68.73726
6 60.82331 59.13420 62.51242 52.90936 68.73726
```

Построим линию регрессии и визуализируем доверительные области:

![](https://github.com/IHappyPlant/Data_Analysis/blob/master/images/homework_2/hw2_regression_line_confidence_intervals.png)

### Множественная регрессия

Проведём анализ зависимости переменной ```stack.loss``` от всех остальных переменных.

Построим модель регрессии:

```R
> fm1 <- lm(stack.loss~., data = data)
> summary(fm1)

Call:
lm(formula = stack.loss ~ ., data = data)

Residuals:
    Min      1Q  Median      3Q     Max 
-7.2377 -1.7117 -0.4551  2.3614  5.6978 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) -39.9197    11.8960  -3.356  0.00375 ** 
Air.Flow      0.7156     0.1349   5.307  5.8e-05 ***
Water.Temp    1.2953     0.3680   3.520  0.00263 ** 
Acid.Conc.   -0.1521     0.1563  -0.973  0.34405    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 3.243 on 17 degrees of freedom
Multiple R-squared:  0.9136,	Adjusted R-squared:  0.8983 
F-statistic:  59.9 on 3 and 17 DF,  p-value: 3.016e-09
```

Значимыми являются коэффициенты ```(Intercept)```, ```Air.Flow``` и ```Water.Temp```. Модель в целом также является статистически значимой.

Построим таблицу дисперсионного анализа:

```R
> anova(fm1)

Analysis of Variance Table

Response: stack.loss
           Df  Sum Sq Mean Sq  F value    Pr(>F)    
Air.Flow    1 1750.12 1750.12 166.3707 3.309e-10 ***
Water.Temp  1  130.32  130.32  12.3886  0.002629 ** 
Acid.Conc.  1    9.97    9.97   0.9473  0.344046    
Residuals  17  178.83   10.52
```

Наибольший вклад вносят переменные ```Air.Flow``` и ```Water.Temp```.

Построим таблицу наблюдаемых и предсказанных значений для ```stack.loss```:

```R
> predict.fm1 = predict.lm(fm1)
> tabout <- cbind(data$stack.loss, predict.fm1)
> head(tabout, n = 30)

      predict.fm1
1  42   38.765363
2  37   38.917485
3  37   32.444467
4  28   22.302226
5  18   19.711654
6  18   21.006940
7  19   21.389491
8  20   21.389491
9  15   18.144379
10 14   12.732806
11 14   11.363703
12 13   10.220540
13 11   12.428561
14 12   12.050499
15  8    5.638582
16  7    6.094949
17  8    9.519951
18  8    8.455093
19  9    9.598257
20 15   13.587853
21 15   22.237713
```

Построим диаграмму квантиль-квантиль:

![](https://github.com/IHappyPlant/Data_Analysis/blob/master/images/homework_2/hw2_fm1_qqplot.png)

### Пошаговая множественная регрессия

Построим пошаговуб модель множественной регрессии:

```R
> fm2 <- step(lm(stack.loss~., data = data))
> summary(fm2)

Start:  AIC=52.98
stack.loss ~ Air.Flow + Water.Temp + Acid.Conc.

             Df Sum of Sq    RSS    AIC
- Acid.Conc.  1     9.965 188.80 52.119
<none>                    178.83 52.980
- Water.Temp  1   130.308 309.14 62.475
- Air.Flow    1   296.228 475.06 71.497

Step:  AIC=52.12
stack.loss ~ Air.Flow + Water.Temp

             Df Sum of Sq    RSS    AIC
<none>                    188.80 52.119
- Water.Temp  1    130.32 319.12 61.142
- Air.Flow    1    294.36 483.15 69.852

Call:
lm(formula = stack.loss ~ Air.Flow + Water.Temp, data = data)

Residuals:
    Min      1Q  Median      3Q     Max 
-7.5290 -1.7505  0.1894  2.1156  5.6588 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) -50.3588     5.1383  -9.801 1.22e-08 ***
Air.Flow      0.6712     0.1267   5.298 4.90e-05 ***
Water.Temp    1.2954     0.3675   3.525  0.00242 ** 
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 3.239 on 18 degrees of freedom
Multiple R-squared:  0.9088,	Adjusted R-squared:  0.8986 
F-statistic: 89.64 on 2 and 18 DF,  p-value: 4.382e-10
```

На старте алгоритма, значение ```AIC``` составляло ```52.98```. По итогу работы, значение ```AIC``` составило ```52.12```, что означает, что модель регрессии улучшилась после удаления незначащих переменных.

Выполним анализ вариаций:

```R
> anova(fm2)

Analysis of Variance Table

Response: stack.loss
           Df  Sum Sq Mean Sq F value    Pr(>F)    
Air.Flow    1 1750.12 1750.12 166.859 1.528e-10 ***
Water.Temp  1  130.32  130.32  12.425  0.002419 ** 
Residuals  18  188.80   10.49
```

Выведем таблицу наблюдаемых и предсказанных значений, и проиллюстрируем её на графике квантиль-квантиль:

```R
> predict.fm2 <- predict.lm(fm2)
> tabout2 <- cbind(data$stack.loss, predict.fm2)
> head(tabout2, n = 30)

      predict.fm2
1  42   38.308002
2  37   38.308002
3  37   32.361527
4  28   22.341168
5  18   19.750465
6  18   21.045817
7  19   22.341168
8  20   22.341168
9  15   18.361199
10 14   11.884442
11 14   11.884442
12 13   10.589091
13 11   11.884442
14 12   13.179793
15  8    6.515207
16  7    6.515207
17  8    7.810558
18  8    7.810558
19  9    9.105909
20 15   13.132836
21 15   22.528998
```

![](https://github.com/IHappyPlant/Data_Analysis/blob/master/images/homework_2/hw2_fm2_qqplot.png)

## Дисперсионный анализ

В данной работе проводится построение и анализ нескольких дисперсионных моделей для выборки ```npk```.

Выведем выборку:

```R
> data <- npk
> data

   block N P K yield
1      1 0 1 1  49.5
2      1 1 1 0  62.8
3      1 0 0 0  46.8
4      1 1 0 1  57.0
5      2 1 0 0  59.8
6      2 1 1 1  58.5
7      2 0 0 1  55.5
8      2 0 1 0  56.0
9      3 0 1 0  62.8
10     3 1 1 1  55.8
11     3 1 0 0  69.5
12     3 0 0 1  55.0
13     4 1 0 0  62.0
14     4 1 1 1  48.8
15     4 0 0 1  45.5
16     4 0 1 0  44.2
17     5 1 1 0  52.0
18     5 0 0 0  51.5
19     5 1 0 1  49.8
20     5 0 1 1  48.8
21     6 1 0 1  57.2
22     6 1 1 0  59.0
23     6 0 1 1  53.2
24     6 0 0 0  56.0
```

Получим описательную статистику по всей выборке:

```R
> summary(data)

 block N      P      K          yield      
 1:4   0:12   0:12   0:12   Min.   :44.20  
 2:4   1:12   1:12   1:12   1st Qu.:49.73  
 3:4                        Median :55.65  
 4:4                        Mean   :54.88  
 5:4                        3rd Qu.:58.62  
 6:4                        Max.   :69.50
```

Получим описательную статистику по группам:

```R
> means <- tapply(data$yield, data$block, mean)
> means

     1      2      3      4      5      6 
54.025 57.450 60.775 50.125 50.525 56.350 
```

Построим графики для визуализации различия средних:

![](https://github.com/IHappyPlant/Data_Analysis/blob/master/images/homework_3/hw3_stripchart.png)

![hw3_boxplot](https://github.com/IHappyPlant/Data_Analysis/blob/master/images/homework_3/hw3_boxplot.png)

Оценим нормальность распределения ```yield```:

![](https://github.com/IHappyPlant/Data_Analysis/blob/master/images/homework_3/density_hist.png)

![](https://github.com/IHappyPlant/Data_Analysis/blob/master/images/homework_3/density_plot.png)Проведём тест Шапиро для проверки нормальности распределения:

```R
> shapiro.test(data$yield)

	Shapiro-Wilk normality test

data:  data$yield
W = 0.97884, p-value = 0.8735
```

Значение теста Шапиро подтверждает нормальность распределения для ```yield``` по всей выборке.

Проведём тест Бартлетта для проверки дисперсии по группам:

```R
> bartlett.test(data$yield, data$block)

	Bartlett test of homogeneity of variances

data:  data$yield and data$block
Bartlett's K-squared = 11.508, df = 5, p-value = 0.04219
```

Из результатов теста Бартлета следует, что дисперсия по группам неоднородна ```(p-value < 0.05)```.

### Однофакторный дисперсионный анализ

Выполним однофакторный дисперсионный анализ:

```R
> summary(aov(yield ~ block, data = data))
            Df Sum Sq Mean Sq F value Pr(>F)  
block        5  343.3   68.66   2.318 0.0861 .
Residuals   18  533.1   29.61                 
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```

```p-value = 0.08 > 0.05```, из чего следует, что гипотезу о несущественности различия средних следует принять. Из этого следует, что различные комбинации значений ```N```, ```P```, ```K``` не оказывают существенного влияния на значение ```yield```.

Построим линейную модель дисперсионного анализа:

```R
> summary(lm(yield ~  block, data = data))

Call:
lm(formula = yield ~ block, data = data)

Residuals:
    Min      1Q  Median      3Q     Max 
-7.2250 -3.4937 -0.5375  2.1062 11.8750 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)   54.025      2.721  19.855 1.09e-13 ***
block2         3.425      3.848   0.890   0.3852    
block3         6.750      3.848   1.754   0.0964 .  
block4        -3.900      3.848  -1.013   0.3243    
block5        -3.500      3.848  -0.910   0.3751    
block6         2.325      3.848   0.604   0.5532    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 5.442 on 18 degrees of freedom
Multiple R-squared:  0.3917,	Adjusted R-squared:  0.2228 
F-statistic: 2.318 on 5 and 18 DF,  p-value: 0.08607
```

Здесь также видно, что ни одна из переменных не имеет существенного вклада в уравнение регрессии.

Поскольку дисперсия по группам была неоднородной, применим для дисперсионного анализа метод Уэлча:

```R
> oneway.test(yield ~  block, data = data)

	One-way analysis of means (not assuming equal variances)

data:  yield and block
F = 6.2463, num df = 5.0000, denom df = 8.0508, p-value = 0.01178
```

```p-value > 0.05``` для теста Уэлча означает, что гипотезу о несущественности различия средних следует отклонить, хотя на графиках и всех остальных тестах видно обратное. Таким образом, имеется два противоречащих значения. Для устранения неопределённости можно провести двухфакторный дисперсионный анализ.

### Двухфакторный дисперсионный анализ

Построим график плана эксперимента, и графики взаимодействия переменной ```yield``` с 

каждой из переменных ```N```, ```P```, ```K```:

![](https://github.com/IHappyPlant/Data_Analysis/blob/master/images/homework_3/experiment_plan_plot.png)

![](https://github.com/IHappyPlant/Data_Analysis/blob/master/images/homework_3/yield_n_plot.png)

![](https://github.com/IHappyPlant/Data_Analysis/blob/master/images/homework_3/yield_p_plot.png)

![](https://github.com/IHappyPlant/Data_Analysis/blob/master/images/homework_3/yield_k_plot.png)

Проведём двухфакторный дисперсионный анализ для проверки связи переменной ```yield``` с каждой из переменных ```N```, ```P```, ```K```:

```R
> mwb <- aov(yield ~ N + block + N:block, data = data)
> summary(mwb)
            Df Sum Sq Mean Sq F value Pr(>F)  
N            1  189.3  189.28   9.261 0.0102 *
block        5  343.3   68.66   3.359 0.0397 *
N:block      5   98.5   19.70   0.964 0.4769  
Residuals   12  245.3   20.44                 
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

> mwb <- aov(yield ~ P + block + P:block, data = data)
> summary(mwb)
            Df Sum Sq Mean Sq F value Pr(>F)
P            1    8.4    8.40   0.222  0.646
block        5  343.3   68.66   1.818  0.184
P:block      5   71.4   14.28   0.378  0.854
Residuals   12  453.3   37.77 

> mwb <- aov(yield ~ K + block + K:block, data = data)
> summary(mwb)
            Df Sum Sq Mean Sq F value Pr(>F)
K            1   95.2   95.20   3.108  0.103
block        5  343.3   68.66   2.241  0.117
K:block      5   70.3   14.05   0.459  0.799
Residuals   12  367.6   30.63
```

Полученные значения показывают, что переменная ```N``` вносит больший вклад в значение переменной ```yield```, чем другие.

## Канонический анализ

В работе проводится канонический анализ для различных подмножеств переменных выборки ```LifeCycleSavings```.

Выведем выборку ```LifeCycleSavings```:

```R
> lcs <- LifeCycleSavings
> lcs
                  sr pop15 pop75     dpi  ddpi
Australia      11.43 29.35  2.87 2329.68  2.87
Austria        12.07 23.32  4.41 1507.99  3.93
Belgium        13.17 23.80  4.43 2108.47  3.82
Bolivia         5.75 41.89  1.67  189.13  0.22
Brazil         12.88 42.19  0.83  728.47  4.56
Canada          8.79 31.72  2.85 2982.88  2.43
Chile           0.60 39.74  1.34  662.86  2.67
China          11.90 44.75  0.67  289.52  6.51
Colombia        4.98 46.64  1.06  276.65  3.08
Costa Rica     10.78 47.64  1.14  471.24  2.80
Denmark        16.85 24.42  3.93 2496.53  3.99
Ecuador         3.59 46.31  1.19  287.77  2.19
Finland        11.24 27.84  2.37 1681.25  4.32
France         12.64 25.06  4.70 2213.82  4.52
Germany        12.55 23.31  3.35 2457.12  3.44
Greece         10.67 25.62  3.10  870.85  6.28
Guatamala       3.01 46.05  0.87  289.71  1.48
Honduras        7.70 47.32  0.58  232.44  3.19
Iceland         1.27 34.03  3.08 1900.10  1.12
India           9.00 41.31  0.96   88.94  1.54
Ireland        11.34 31.16  4.19 1139.95  2.99
Italy          14.28 24.52  3.48 1390.00  3.54
Japan          21.10 27.01  1.91 1257.28  8.21
Korea           3.98 41.74  0.91  207.68  5.81
Luxembourg     10.35 21.80  3.73 2449.39  1.57
Malta          15.48 32.54  2.47  601.05  8.12
Norway         10.25 25.95  3.67 2231.03  3.62
Netherlands    14.65 24.71  3.25 1740.70  7.66
New Zealand    10.67 32.61  3.17 1487.52  1.76
Nicaragua       7.30 45.04  1.21  325.54  2.48
Panama          4.44 43.56  1.20  568.56  3.61
Paraguay        2.02 41.18  1.05  220.56  1.03
Peru           12.70 44.19  1.28  400.06  0.67
Philippines    12.78 46.26  1.12  152.01  2.00
Portugal       12.49 28.96  2.85  579.51  7.48
South Africa   11.14 31.94  2.28  651.11  2.19
South Rhodesia 13.30 31.92  1.52  250.96  2.00
Spain          11.77 27.74  2.87  768.79  4.35
Sweden          6.86 21.44  4.54 3299.49  3.01
Switzerland    14.13 23.49  3.73 2630.96  2.70
Turkey          5.13 43.42  1.08  389.66  2.96
Tunisia         2.81 46.12  1.21  249.87  1.13
United Kingdom  7.81 23.27  4.46 1813.93  2.01
United States   7.56 29.81  3.43 4001.89  2.45
Venezuela       9.22 46.40  0.90  813.39  0.53
Zambia         18.56 45.25  0.56  138.33  5.14
Jamaica         7.72 41.12  1.73  380.47 10.23
Uruguay         9.24 28.13  2.72  766.54  1.88
Libya           8.89 43.69  2.07  123.58 16.71
Malaysia        4.71 47.20  0.66  242.69  5.08
```

Получим описательную статистику и матрицу корреляции:

```R
> summary(lcs)
       sr             pop15           pop75            dpi               ddpi       
 Min.   : 0.600   Min.   :21.44   Min.   :0.560   Min.   :  88.94   Min.   : 0.220  
 1st Qu.: 6.970   1st Qu.:26.21   1st Qu.:1.125   1st Qu.: 288.21   1st Qu.: 2.002  
 Median :10.510   Median :32.58   Median :2.175   Median : 695.66   Median : 3.000  
 Mean   : 9.671   Mean   :35.09   Mean   :2.293   Mean   :1106.76   Mean   : 3.758  
 3rd Qu.:12.617   3rd Qu.:44.06   3rd Qu.:3.325   3rd Qu.:1795.62   3rd Qu.: 4.478  
 Max.   :21.100   Max.   :47.64   Max.   :4.700   Max.   :4001.89   Max.   :16.710  
> cor(lcs)
              sr       pop15       pop75        dpi        ddpi
sr     1.0000000 -0.45553809  0.31652112  0.2203589  0.30478716
pop15 -0.4555381  1.00000000 -0.90847871 -0.7561881 -0.04782569
pop75  0.3165211 -0.90847871  1.00000000  0.7869995  0.02532138
dpi    0.2203589 -0.75618810  0.78699951  1.0000000 -0.12948552
ddpi   0.3047872 -0.04782569  0.02532138 -0.1294855  1.00000000
```

Из матрицы корреляции видно, что сильнее всего связаны переменные ```pop15```, ```pop75``` и ```dpi```. Переменные ```sr``` и ```ddpi``` слабо связаны с остальными. На основании этого, объединим переменные ```pop15```, ```pop75``` и ```dpi``` в одно подмножество ```x```, а переменные ```sr``` и ```ddpi``` - в подмножество ```y```:

```R
> x <- lcs[2:4]
> y <- cbind(lcs[1], lcs[5])
```

Построим матрицы корреляции для полученных подмножеств:

```R
> cor(x)
           pop15      pop75        dpi
pop15  1.0000000 -0.9084787 -0.7561881
pop75 -0.9084787  1.0000000  0.7869995
dpi   -0.7561881  0.7869995  1.0000000
> cor(y)
            sr      ddpi
sr   1.0000000 0.3047872
ddpi 0.3047872 1.0000000
```

Можно видеть, что все коэффициенты корреляции сохранились.

Проведём канонический анализ:

```R
> cxy <- cancor(x, y)
> cxy
$cor
[1] 0.5264128 0.2468310

$xcoef
               [,1]          [,2]          [,3]
pop15 -2.984865e-02  0.0028588468 -2.307619e-02
pop75 -1.011675e-01 -0.1051054829 -2.442859e-01
dpi   -3.839998e-05  0.0002330122  1.649138e-05

$ycoef
            [,1]        [,2]
sr    0.03283325  0.00653719
ddpi -0.00590285 -0.05193059

$xcenter
    pop15     pop75       dpi 
  35.0896    2.2930 1106.7584 

$ycenter
    sr   ddpi 
9.6710 3.7576
```

Значение первого канонического корня означает, что множества средне связаны между собой.

Проведём проверку значимости канонических корреляций:

```R
> n <- dim(x)[1] # number of observations
> p <- dim(x)[2] # number of dependent variables
> q <- dim(y)[2] # number of independent variables
> n;p;q
[1] 50
[1] 3
[1] 2
> wilks_test <- p.asym(rho=cxy$cor, n, p, q, tstat = "Wilks")
Wilks' Lambda, using F-approximation (Rao's F):
              stat   approx df1 df2     p.value
1 to 2:  0.6788471 3.205611   6  90 0.006726398
2 to 2:  0.9390745 1.492200   2  46 0.235559566
```

Значения ```p-value ``` говорят о том, что значимостью обладают только модели из одной переменной.

Проведём перестановочные тесты:

```R
> p.perm(x, y, rhostart=1)
 Permutation resampling using Wilks 's statistic:
     stat0     mstat nboot nexcess          p
 0.6788471 0.8821888   999      10 0.01001001
> p.perm(x, y, rhostart=2)
 Permutation resampling using Wilks 's statistic:
     stat0     mstat nboot nexcess          p
 0.9390745 0.9805179   999      44 0.04404404
```

Значения ```p-value < 0.05 ``` перестановочных тестов говорят о том, что два подмножества ```x``` и ```y``` кореллируют между собой.

