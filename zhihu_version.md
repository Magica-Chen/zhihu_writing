# Gaussian process classification初介绍——回归与分类其实只有一线之隔

利用贝叶斯定理，我们可以将这个联合（密度）概率可以表示成为<img src="https://www.zhihu.com/equation?tex=p(y)p(x|y)" alt="p(y)p(x|y)" class="ee_img tr_noresize" eeimg="1">或者<img src="https://www.zhihu.com/equation?tex=p(x)p(y|x)" alt="p(x)p(y|x)" class="ee_img tr_noresize" eeimg="1">，因而这里又可以有两者不同方式去处理这个概率化分类：

1. 通过<img src="https://www.zhihu.com/equation?tex=p(y)p(x|y)" alt="p(y)p(x|y)" class="ee_img tr_noresize" eeimg="1">，叫做generative approach。它的本质是，我们知道一些关于class的信息，即<img src="https://www.zhihu.com/equation?tex=p(y)" alt="p(y)" class="ee_img tr_noresize" eeimg="1"> 对于<img src="https://www.zhihu.com/equation?tex=y=C_1, C_2, \cdots, C_C" alt="y=C_1, C_2, \cdots, C_C" class="ee_img tr_noresize" eeimg="1">，而我们需要设法知道class-conditional distribution，<img src="https://www.zhihu.com/equation?tex=p(x|y)" alt="p(x|y)" class="ee_img tr_noresize" eeimg="1">， 然后我们就可以得到关于每一个class的后验分布，即
   

<img src="https://www.zhihu.com/equation?tex=   p(y|x) = \frac{p(y)p(x|y)}{\sum_{c=1}^C p(C_c)p(x|C_c)}.
   " alt="   p(y|x) = \frac{p(y)p(x|y)}{\sum_{c=1}^C p(C_c)p(x|C_c)}.
   " class="ee_img tr_noresize" eeimg="1">

   这个方法也被Dawid称作是sampling paradigms。

2. 直接考虑<img src="https://www.zhihu.com/equation?tex=p(y|x)" alt="p(y|x)" class="ee_img tr_noresize" eeimg="1">，叫做discriminative approach。也叫被Dawid称作是diagnostic paradigms。

