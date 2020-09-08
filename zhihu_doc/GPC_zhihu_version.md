![f8](https://raw.githubusercontent.com/Magica-Chen/zhihu_writing/master/img/f8.gif)

# Gaussian Process Classification 再介绍——从详细的二分类开始

的确又是好久木有更新啦，这次我们来火速结束高斯过程分类的话题。

为了让大家可以适应，我们还是先来简单又详细的说一下线性的二分类吧！

啊？什么？不是说要终结高斯过程分类了么？为什么还是线性模型呀？

嗯， 啊，哦，其实，好吧。。。这是开胃菜了哈！

其实这是为了让那些没有太多基础的小伙伴可以再有个预热，为了之后更好的理解后面的内容，同时对于那里已经准备的小伙伴当做是复习功课了哈，如果你们还有兴趣的话。

## 线性二分类

![机器学习分类算法之逻辑回归](https://raw.githubusercontent.com/Magica-Chen/zhihu_writing/master/img/l)

首先我们考虑这个线性二分类的问题，先让我们引入几个符号，当然这个符号不是一定要那么写，这样写不过是为了后面叙述方便而起哈！

二分类，二分类是什么意思呀？

额。。。二分类的意思就是分类的目标标签有两个呀，现在我们可以记作，<img src="https://www.zhihu.com/equation?tex=y=+1" alt="y=+1" class="ee_img tr_noresize" eeimg="1"> 和<img src="https://www.zhihu.com/equation?tex=y=-1" alt="y=-1" class="ee_img tr_noresize" eeimg="1">。当然之后我们也会慢慢讲解多分类的问题，这次我们就“勉为其难”的看个最简单的吧！^V^

这里我们回忆一下两个东西，第一，线性模型，即<img src="https://www.zhihu.com/equation?tex= y = x^T w " alt=" y = x^T w " class="ee_img tr_noresize" eeimg="1">，第二个，probabilistic classification中的概率化方法，即<img src="https://www.zhihu.com/equation?tex=p(y=+1)" alt="p(y=+1)" class="ee_img tr_noresize" eeimg="1">与<img src="https://www.zhihu.com/equation?tex=p(y=-1)" alt="p(y=-1)" class="ee_img tr_noresize" eeimg="1">。因而，最后采用贝叶斯的写法，即


<img src="https://www.zhihu.com/equation?tex=p(y=+1| x,w) = \sigma(x^T w)， \tag{1}" alt="p(y=+1| x,w) = \sigma(x^T w)， \tag{1}" class="ee_img tr_noresize" eeimg="1">



<img src="https://www.zhihu.com/equation?tex=p(y=-1| x,w) = \sigma(x^T w)， \tag{2}" alt="p(y=-1| x,w) = \sigma(x^T w)， \tag{2}" class="ee_img tr_noresize" eeimg="1">


这个(1),(2)表达式由于是表达每个类别的概率，即我们之前所说的likelihood。当然，由于是二分类，其实上述两个式子相加必须等于1！所以，事实上我们只需要考虑其中一个就好啦！这里面的<img src="https://www.zhihu.com/equation?tex=w" alt="w" class="ee_img tr_noresize" eeimg="1">就是线性模型里面的权重，而<img src="https://www.zhihu.com/equation?tex=\sigma(\cdot)" alt="\sigma(\cdot)" class="ee_img tr_noresize" eeimg="1">可以是任意sigmoid函数。

什么是sigmoid函数呀？pia, pia, pia，回去看看前文！！！

[Gaussian process classification初介绍——回归与分类点点滴滴](https://zhuanlan.zhihu.com/p/75072046)

按照前文说的当这个sigmoid函数如果我们采用logistic函数，即


<img src="https://www.zhihu.com/equation?tex=\sigma(z) = \lambda(z) = \frac{1}{1 + \exp(-z)}, \tag{3}" alt="\sigma(z) = \lambda(z) = \frac{1}{1 + \exp(-z)}, \tag{3}" class="ee_img tr_noresize" eeimg="1">



则上面的分类模型叫做，logistic regression。当然由于目前基准模型的表述是线性的，我们自然也可以叫做，linear logistic regression。

若是这个sigmoid函数采用之前所说的正态分布的累计密度函数的话，即

<img src="https://www.zhihu.com/equation?tex=\sigma(z) = \Phi(z) = \int_{-\infty}^x \mathcal{N}(x|0,1)dx, \tag{4}" alt="\sigma(z) = \Phi(z) = \int_{-\infty}^x \mathcal{N}(x|0,1)dx, \tag{4}" class="ee_img tr_noresize" eeimg="1">

那么上述的分类模型则叫做，linear probit regression.

事实上，上述两种类型的模型虽然都在regression，但是的的确确是我们后面所说的分类的主要途径，从中我们也可以看到，事实上分类和回归，某种意义上真的他们是一致的哦！

刚才说到对于二分类的问题，+1 与 -1两个类别的相加的概率必须等于1，其实也就是说明了其实sigmoid函数是个奇函数，即

<img src="https://www.zhihu.com/equation?tex=\sigma(z) + \sigma(-z) = 1, \tag{5}" alt="\sigma(z) + \sigma(-z) = 1, \tag{5}" class="ee_img tr_noresize" eeimg="1">

那么现在如果我们给定一系列的<img src="https://www.zhihu.com/equation?tex=(x_i, y_i)" alt="(x_i, y_i)" class="ee_img tr_noresize" eeimg="1"> ，我们如何可以将这个奇函数的特质表达出来呢？

乘法！

我们现在表达式对于无论是probit还是logistic都可以写作，

<img src="https://www.zhihu.com/equation?tex=p(y_i|x_i, w) = \sigma(y_i f_i), \tag{6}" alt="p(y_i|x_i, w) = \sigma(y_i f_i), \tag{6}" class="ee_img tr_noresize" eeimg="1">

这里的<img src="https://www.zhihu.com/equation?tex=f_i" alt="f_i" class="ee_img tr_noresize" eeimg="1">即<img src="https://www.zhihu.com/equation?tex=f(x_i) = x_i^T w" alt="f(x_i) = x_i^T w" class="ee_img tr_noresize" eeimg="1">。仔细来想象这个表达式哈，y可以取值正负，这样不就巧妙的表达出了之前公式（5）中的负号了么？

恩，有道理！

这里再差一个题外话，Logistic regression model另一种表示：

<img src="https://www.zhihu.com/equation?tex=\text{logit}(x) = X^Tw, \text{ where }  \text{ logit }(x) = \log\frac{p(y=+1 |x)}{p(y=-1|x)}. \nonumber" alt="\text{logit}(x) = X^Tw, \text{ where }  \text{ logit }(x) = \log\frac{p(y=+1 |x)}{p(y=-1|x)}. \nonumber" class="ee_img tr_noresize" eeimg="1">

这里其实不难得到，只要聪明的你知道<img src="https://www.zhihu.com/equation?tex=p(y=-1|x) = 1 - p(y=+1|x) = \frac{\exp(-X^T w)}{1 + \exp(-X^T w)}" alt="p(y=-1|x) = 1 - p(y=+1|x) = \frac{\exp(-X^T w)}{1 + \exp(-X^T w)}" class="ee_img tr_noresize" eeimg="1">即可！这里的这个logit函数又可以被称作log odds ratio.



好啦，言归正传， 现在我们重新来正式考虑与之前我们讨论回归问题的时候一样，<img src="https://www.zhihu.com/equation?tex=w" alt="w" class="ee_img tr_noresize" eeimg="1">的posterior了哦！给定我们的数据集，<img src="https://www.zhihu.com/equation?tex=\mathcal{D} = \{(x_i, y_i)| i=1,2,\cdots, n\}" alt="\mathcal{D} = \{(x_i, y_i)| i=1,2,\cdots, n\}" class="ee_img tr_noresize" eeimg="1">。当然这里我们也需要假设这些标签<img src="https://www.zhihu.com/equation?tex=y_i" alt="y_i" class="ee_img tr_noresize" eeimg="1">现在只能取正负1，而且在给定线性函数<img src="https://www.zhihu.com/equation?tex=f(x) = x^T w" alt="f(x) = x^T w" class="ee_img tr_noresize" eeimg="1">需要是独立产生的哈！

现在我们还是使用<img src="https://www.zhihu.com/equation?tex=w" alt="w" class="ee_img tr_noresize" eeimg="1">来自高斯的先验<img src="https://www.zhihu.com/equation?tex=w \sim \mathcal{N}(0, \Sigma_p)" alt="w \sim \mathcal{N}(0, \Sigma_p)" class="ee_img tr_noresize" eeimg="1">，这点跟之前我们将回归的时候一样哈！忘记的小伙伴可以回去在看看

[Gaussian process regression的导出——权重空间视角下的贝叶斯的方法](https://zhuanlan.zhihu.com/p/27554656)

此时，这个权重<img src="https://www.zhihu.com/equation?tex=w" alt="w" class="ee_img tr_noresize" eeimg="1">的log后验也可以得到：

<img src="https://www.zhihu.com/equation?tex=\log p (w | \mathcal{D}) \propto \log ( p (y | X, w) p(w)) = -\frac{1}{2}w^T \Sigma^{-1}_p w + \sum_{i=1}^n\log \sigma(y_if_i), \tag{7}" alt="\log p (w | \mathcal{D}) \propto \log ( p (y | X, w) p(w)) = -\frac{1}{2}w^T \Sigma^{-1}_p w + \sum_{i=1}^n\log \sigma(y_if_i), \tag{7}" class="ee_img tr_noresize" eeimg="1">

这里<img src="https://www.zhihu.com/equation?tex=\propto" alt="\propto" class="ee_img tr_noresize" eeimg="1">表示忽略常系数比例相同。

看到这里，或许聪明的小伙伴还是去跟regression的时候我们的推导进行比较，我们发现，在linear的regression模型的时候我们最终这个w的后验我们仍然可以得到一个有具体mean和(co)variance表达式的高斯分布。

而现在，对于分类问题，我们却多出了一项，<img src="https://www.zhihu.com/equation?tex=\sum_{i=1}^n\log \sigma(y_if_i)" alt="\sum_{i=1}^n\log \sigma(y_if_i)" class="ee_img tr_noresize" eeimg="1">。这下似乎麻烦了，因为这个<img src="https://www.zhihu.com/equation?tex=\sigma(\cdot)" alt="\sigma(\cdot)" class="ee_img tr_noresize" eeimg="1">函数似乎看上长的并不太规整呀显然这个也不应该再是高斯的啦，所以是不是可能不太好算呀？

对，没错，在分类问题中，正是由于这个多出来的一项，直接导致了权重的后验无法得到解析的结果，因此某种意义下，这也是分类比回归稍微复杂一些的地方哈！

不过问题其实也不算是最坏，毕竟现在我们手里有的条件是第一这个二分类，第二我们的sigmoid函数现在仅仅考虑两种logistic和probit。

现在我之所以说结果还不是很坏的原因就在于这个最优化与凹凸函数的问题里面哈！忘记的小伙伴再去复习一下哈！

[Gaussian process 的最后一步——话说超参学习](https://zhuanlan.zhihu.com/p/39118553)

这里要说的即，当sigmoid函数考虑logistic和probit的时候，最后这个我们的分类模型的log likelihood将会是个concave的函数，因而最后的<img src="https://www.zhihu.com/equation?tex=w" alt="w" class="ee_img tr_noresize" eeimg="1">的log后验也可以是个concave函数，那么就是至少在理论上可以说明一点，即我们可以找到全局最大值！！！

至于为什么， 有兴趣的小伙伴可以参见wiki， [Concave function](https://en.wikipedia.org/wiki/Concave_function)。

至于小伙伴还要问， 为什么logistic和probit也可以是concave的呢？不不不，不是logistic和probit是concave，而是logistic和probit取了log之后他们才是concave的哦！这个问题嘛，有兴趣的小伙伴可以自己动手算一算哈！即二阶导数或者多维情况的则是Hessian矩阵是负定即可以说明concavity哦！

至于较真的小伙伴还会问：“现在我知道公式（7）里面的后半部分已经是concave了，那么为什么最终还是concave了呢，前面还有个负的二次型呢？”

恩，这样的小伙伴一定是认真的小伙伴哈！这个问题，其实你若是自己动手算一算也是可以得到这个一定性质的哦，一个二次型的性质的哦！即，负定二次型必定concave的呀！，这个的理解其是跟之前的Hessian是一致的哦！这里还有其实证明的实际操作哈（[quadratic form is convex](https://math.stackexchange.com/questions/2122742/proving-that-a-quadratic-form-is-convex)），有兴趣的小伙伴也可以看看哈

当然，严密的来讲，我们还是需要论证的一点是concave + concave = concave,这个当然可以算是concave的一个性质哦！这个相关证明解答直接参看wiki就好了哈！

既然我们现在之后知道log后验理论上可以得到求得最大值了，那么各路牛鬼蛇神的算法都可以用啦，只要算得够久，得到结果自然是迟早的事情，比如这里可以用牛顿法呀，共轭梯度呀等等方法都可以求解哈，差别无非是谁比谁快而已。

再然后，我们还需要考虑预测，此时，同样的配方同样表述，与回归的时候也是一致，即[Gaussian process regression的导出——权重空间视角下的贝叶斯的方法](https://zhuanlan.zhihu.com/p/27554656)， 即类似这里面的公式（5），给定训练集<img src="https://www.zhihu.com/equation?tex=\mathcal{D}" alt="\mathcal{D}" class="ee_img tr_noresize" eeimg="1">与测试点<img src="https://www.zhihu.com/equation?tex=x_*" alt="x_*" class="ee_img tr_noresize" eeimg="1">, 不过现在我们公式要变成了：

<img src="https://www.zhihu.com/equation?tex=p(y_* = +1 |x_*, \mathcal{D}) = \int p(y_* = +1|w, x_*) p(w|\mathcal{D})dw, \tag{8}" alt="p(y_* = +1 |x_*, \mathcal{D}) = \int p(y_* = +1|w, x_*) p(w|\mathcal{D})dw, \tag{8}" class="ee_img tr_noresize" eeimg="1">

这个公式（8）虽然不好算，但是只要按照<img src="https://www.zhihu.com/equation?tex=w" alt="w" class="ee_img tr_noresize" eeimg="1">的后验的分布进行取样，<img src="https://www.zhihu.com/equation?tex=p(w|\mathcal{D})" alt="p(w|\mathcal{D})" class="ee_img tr_noresize" eeimg="1">自然是可以算的哈，至于<img src="https://www.zhihu.com/equation?tex=p(y_* = +1|w, x_*) " alt="p(y_* = +1|w, x_*) " class="ee_img tr_noresize" eeimg="1">如果我们可以给定logistic或者probit，自然也是可以算得，那么结果自然我们得到最终的prediction哦！这其实不过就是一种分割求和取极限的算积分思想哦！

## 实例展示

方便起见，这里我们就不再自己作图啦，直接上[1]中的图来说明一下我们这个例子吧！

![image-20200525232531279](https://raw.githubusercontent.com/Magica-Chen/zhihu_writing/master/img/image-20200525232531279.png)

这里的(a)是一个二维的<img src="https://www.zhihu.com/equation?tex=w" alt="w" class="ee_img tr_noresize" eeimg="1">先验，即我们知道这个权重满足标准的正态分布，这里的实心曲线则是等概率密度线，即线上的所有点具有相同的概率密度。现在我们给定我们的数据点分布(b)，这里的叉号与空点圆分别表示两个不同的类别标签，即可以表示出给定数据点后的likelihood，通过贝叶斯的框架，我们可以得到图(c)，即<img src="https://www.zhihu.com/equation?tex=w" alt="w" class="ee_img tr_noresize" eeimg="1">的后验分布，此时我们可以清楚的看到这个后验分布的等概率密度线不再均匀，自然也不会是正态的情况啦！最后当我们给定整个<img src="https://www.zhihu.com/equation?tex=x_1, x_2" alt="x_1, x_2" class="ee_img tr_noresize" eeimg="1">平面上的所有点，我们可以得到整个平面上的等概率图(d)， 即预测分布<img src="https://www.zhihu.com/equation?tex=p(y_* = 1 |x_*)" alt="p(y_* = 1 |x_*)" class="ee_img tr_noresize" eeimg="1">。图中中间值为0.5，两边分别是小于和大于的，如果以0.5为界限，则左下为一类，右上则为另一类。

## 高斯过程分类

上述就是简要版的线性二分类，那么我们即将要说的高斯过程二分类其实就是在这个基础上的一种延伸。在公式（6）中我们定义了<img src="https://www.zhihu.com/equation?tex=f(x) = X^T w" alt="f(x) = X^T w" class="ee_img tr_noresize" eeimg="1">这种线性的表达形式，而现在我们的高斯过程分类，则是可以考虑一般化的<img src="https://www.zhihu.com/equation?tex=f(x)" alt="f(x)" class="ee_img tr_noresize" eeimg="1">，即所谓的在<img src="https://www.zhihu.com/equation?tex=f(x)" alt="f(x)" class="ee_img tr_noresize" eeimg="1">上放置一个高斯过程的prior。

这里你可能好学的小伙伴又会有疑惑，之前线性的时候你假设其实线性模型，则我们有了表达式<img src="https://www.zhihu.com/equation?tex=f(x) = X^T w" alt="f(x) = X^T w" class="ee_img tr_noresize" eeimg="1">，这样其实也就假设了模型是满足线性的，那么你现在说<img src="https://www.zhihu.com/equation?tex=f(x)" alt="f(x)" class="ee_img tr_noresize" eeimg="1">上放置了一个高斯过程的prior，是不是说我们的<img src="https://www.zhihu.com/equation?tex=f(x)" alt="f(x)" class="ee_img tr_noresize" eeimg="1">一定要满足高斯分布呢？

答案显然不是，如果你此时还是疑惑这个问题的话，那么还请仔仔细细，认认真真再读一遍，这个文章与这个回答：

[什么是Gaussian process? —— 说说高斯过程与高斯分布的关系](https://zhuanlan.zhihu.com/p/27555501)

[高斯分布与高斯过程的区别是什么？](https://www.zhihu.com/question/383146777/answer/1114064531)

这里放置一个GP的prior其实等于什么都没有放，逻辑是给定一组数据，或许我们并不知道它们是不是一定是来自某一个的高斯过程的，但是总有那么一个高斯过程的一个realization会通过这所有的有限个点数据。

这里其实还能引出一个关于参数化模型与非参数话模型，从线性表达式中我们可以看到，一旦模型给定，权重<img src="https://www.zhihu.com/equation?tex=w" alt="w" class="ee_img tr_noresize" eeimg="1">通过学习得到后，那么整个模型就是完全被确定的，这就是参数化模型，这样的情况我们可以看到似乎一切都已经被完全确定，一旦我们的假设，即模型是线性这个条件一旦不成立，我们最终的结果就可能千差万别。反观，我们的高斯过程模型，我们放置了个GP的prior，看上去不也就是也放个了一些参数，即mean function ，kernel里面的超参数，但是差别就在于，通过模型的学习后，即便是我们确定了这些超参数，我们这个模型仍然是随机的，因为一个确定mean function与kernel的GP的表达式可以对应着不穷个GP的realization哦！所以这个意义上高斯过程是一个非参数化的方法，因而，它能够解释和解决的问题可以更复杂更多变！

具体的解释也可以参见这个文章：

[高斯过程说它是非参数模型，这点怎么理解？](https://www.zhihu.com/question/54354940/answer/139029700)



好了回到我们的整体Gaussian Process Classification （GPC）

现在我们定义：

<img src="https://www.zhihu.com/equation?tex=\pi(x) : = p(y=+1|x) = \sigma(f(x)) \tag{9}" alt="\pi(x) : = p(y=+1|x) = \sigma(f(x)) \tag{9}" class="ee_img tr_noresize" eeimg="1">

这里<img src="https://www.zhihu.com/equation?tex=\pi(\cdot)" alt="\pi(\cdot)" class="ee_img tr_noresize" eeimg="1">是一个依赖于<img src="https://www.zhihu.com/equation?tex=f" alt="f" class="ee_img tr_noresize" eeimg="1">的deterministic函数，这里的<img src="https://www.zhihu.com/equation?tex=f" alt="f" class="ee_img tr_noresize" eeimg="1">是一个函数哦！此时我们的GPC相当于用一般化的<img src="https://www.zhihu.com/equation?tex=f" alt="f" class="ee_img tr_noresize" eeimg="1">函数去替换公式（7）中的线性函数。现在这里的latent函数<img src="https://www.zhihu.com/equation?tex=f(\cdot)" alt="f(\cdot)" class="ee_img tr_noresize" eeimg="1">事实上我们并不能观测到，因为我们只知道<img src="https://www.zhihu.com/equation?tex=(X,y)" alt="(X,y)" class="ee_img tr_noresize" eeimg="1">，而最终结果也是我们并不在意这个latent函数的具体内容， 我们更关注的其实是新定义的<img src="https://www.zhihu.com/equation?tex=\pi(x)" alt="\pi(x)" class="ee_img tr_noresize" eeimg="1">，以及之后在测试点上的<img src="https://www.zhihu.com/equation?tex=\pi(x_*)" alt="\pi(x_*)" class="ee_img tr_noresize" eeimg="1">，而<img src="https://www.zhihu.com/equation?tex=f" alt="f" class="ee_img tr_noresize" eeimg="1">的存在就是中间变量，而最后我们需要在通过积分的方式将其去除。

因此在高斯过程分类中，我们的推断方式自然可以分为两个具体步骤，第一， 计算针对给定测试点在我们的latent variable的分布，即

<img src="https://www.zhihu.com/equation?tex=p(f_*| X, y, x_*) = \int p(f_*|X, x_*, f) p(f|X,y) df, \tag{10}" alt="p(f_*| X, y, x_*) = \int p(f_*|X, x_*, f) p(f|X,y) df, \tag{10}" class="ee_img tr_noresize" eeimg="1">

这里<img src="https://www.zhihu.com/equation?tex=p(f_*|X,y, x_*) = p(y|f) p(f|X) / p(y|X)" alt="p(f_*|X,y, x_*) = p(y|f) p(f|X) / p(y|X)" class="ee_img tr_noresize" eeimg="1">从贝叶斯的角度看可以视作是latent variable的后验分布哦！这里的积分是由于我们不知道这个latent的情况，而为了得到最后<img src="https://www.zhihu.com/equation?tex=f_*" alt="f_*" class="ee_img tr_noresize" eeimg="1">我们则需要遍历所有latent variable的所有情况而后相加。

第二部，则是与之前回归一样，利用积分的方式将<img src="https://www.zhihu.com/equation?tex=f_*" alt="f_*" class="ee_img tr_noresize" eeimg="1">也从表达式中去掉，

<img src="https://www.zhihu.com/equation?tex=\pi_*: = \pi(x_*) = p(y_* = +1| \mathcal{D}, x_*) = \int \sigma(f_*)p(f_*|\mathcal{D},x_*)df_*, \tag{11}" alt="\pi_*: = \pi(x_*) = p(y_* = +1| \mathcal{D}, x_*) = \int \sigma(f_*)p(f_*|\mathcal{D},x_*)df_*, \tag{11}" class="ee_img tr_noresize" eeimg="1">

这里<img src="https://www.zhihu.com/equation?tex=\mathcal{D} = (X,y)" alt="\mathcal{D} = (X,y)" class="ee_img tr_noresize" eeimg="1">。



各位小伙伴们，还记不记得我们之前反复强调过，一个高斯的先验与一个高斯的似然，最终可以获得高斯的后验，因而对以回归问题，只要likelihood是高斯的，那么我们在高斯过程回归中最后的prediction总是可以用解析表达式表示的，但是现在我们做的分类就不一定啦。显然分类问题中我们的likelihood不会是高斯的，那么这个公式（10）在积分过程中，自然无法得到一个解析的表达式，同样的道理，在公式（11）中对以大多数的sigmoid函数，只要不是高斯，最终结果也无法解析的表示，即便是看上去如此简单的二元分类问题积分变量一维情况。

因而，对于GPC，我们不得不从一开始就考虑数值方法去求解积分，从而得到最终结果，这里可以选择用的Laplace Approximation，Expectation Propagation（EP）还有目前风头正盛的variational bayes 或者说是variational inference。



啊？什么？最后还是没有得到具体答案呀！！！

![How to answer “What was your greatest disappointment?” | The ...](https://raw.githubusercontent.com/Magica-Chen/zhihu_writing/master/img/disappointed-man190.jpg)



别急别急哈，针对具体的这三种估计的方法，我们之后一个一个的讲，尤其是最后一个variational inference。不过这三个里面关于数学的东西就比较多了哦，最好心理准备哦！不过我相信对于大多数的小伙伴其实，目前各种的代码包都可以直接得到啦，就看你调用哪个啦！就效果来说，目前主流肯定是variational bayes即变分贝叶斯，个人感觉这个的火爆程度都快直追深度学习了哈。。。。



Okay，目前为止大致上关于高斯过程的回归与分类都已经讲完，之后我们将要一步步涉及高斯过程中最为复杂的部分，即各种数值的approximation方法啦！我们下期见哈！

![KEEP CALM BECAUSE I'AM COMING SOON! Poster | kata | Keep Calm-o-Matic](https://raw.githubusercontent.com/Magica-Chen/zhihu_writing/master/img/keep-calm-because-i-am-coming-soon.png)



参看文献

[1] Williams, Christopher KI, and Carl Edward Rasmussen. *Gaussian processes for machine learning*. Vol. 2. No. 3. Cambridge, MA: MIT press, 2006.

