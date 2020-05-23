# Gaussian process classification初介绍——回归与分类其实只有一线之隔

![GPC](D:\OneDrive\zhihu_writing\GPC.png)



这次真的是好久好久木有更新了，以至于有不少小伙伴之后在追问什么时候更新。总的来说目前大多数小伙伴主要还是关心两个问题：

*  高斯过程分类，Gaussian process classification
* 多输出的高斯过程分类

今天我们就先来看看第一个主要的topic，高斯过程分类。



## 回归与分类

其实这个话题，已经有许许多多的博主给出了从通俗形象到晦涩严谨的一系列回答，这里本来并不打算多说，奈何主题是分类，并且需要通过回归去引出，所以这里我也来说简单说说，回归与分类这对“孪生”兄弟的故事。

首先，说起回归Regression与分类Classification，不得不说的是，他们都是一种supervised （监督）学习方法。那么何为监督学习呢？简单的说，监督学习就是：`已知数据标签，想知道更多的数据的未知标签`，具体来说就是**对已知“标签”的数据进行训练学习，为的是最终可以用这些学习到的信息，对之后可能出现的数据的未知“标签”进行预测与归纳**。

什么？还是太复杂？好吧，我们来说个例子吧！

![天气预报](D:\OneDrive\zhihu_writing\weather.png)

对，就是你最熟悉的天气预报！

现在我们有一堆的天气数据，比如气温，气压，湿度，天气状况（晴，多云，雨，雪等等），现在我们也希望做个天气预报。假如我们首先现在希望考察的“标签”是天气情况，那么自然我们希望根据我们所拥有的天气数据，试图去预测明天的天气状况。而此时，如果我们利用相关的机器学习方法，那么势必我们的各种操作都会受限于这个天气情况的“标签”，故此，名曰：监督。事实上，这不光是监督，我们最终的目的也是这些“标签”天气情况，只不过我们已知的过去日子的“标签”，想要知道的是明天未知的“标签”。

当然，其实这个“标签”也不是绝对的，唯一的，这取决于我们的选择。比如，同样是一堆天气数据，我们除了考察天气情况这个“标签”之外，我们还可以考虑气温，气压，温度等等一系列的“标签”。

Okay，仔细的你或许还会发现，这个“标签”和“标签”还长的真不太一样。比如这个气温湿度气压与天气状况就完全不同，温度湿度气压都我们都可以用具体精确表示，比如37摄氏度，30公克/每立方米，10千帕，而与此不同的是这个天气情况就显得没有那么“清晰”啦，只有晴，雨，阴，雪等等。

从简单的数学规律来看，两者的最大区别在于，前者温度湿度气压都连续的数字，比如你可以在37摄氏度与37.1摄氏度中间再找到一个温度，而后者是离散的变量，即你很难说晴和阴之间能精确找到一个变量去代表对应的天气情况。根据这两者的区别，监督学习的两个孪生兄弟，回归Regression与分类Classification就有了分别，即

> 回归是处理连续型“标签”的监督学习方法，而分类是处理离散型变量的监督学习方法！

再深入一些想，是不是可以发现，对于温度湿度气压，你可以定量的去比较两个数据点的大小，因为各自都有自己的比较单位，比如摄氏度，比如帕斯卡，相反对于天气情况，你无法去比较晴与雨的大小高低，只是定性的知道他们是不同，无法量化。因而，这个就引出了一个更为深入的数学概念，__度量__ 。 因而，事实上，回归与分类的本质区别在于：

> 回归是处理可定量分析“标签”的监督学习方法，而分类则是处理只能定性判断“标签”的监督学习方法。

哦，一三四声调，原来如此！！！

当然，若是你再往下思考，其实回归与分类这个对孪生兄弟还可以轻松的去扮演对方。比如气温，如果觉得气温分那么细太麻烦没有必要，你直接就可以考虑低温，常温，高温，三种情况，这样一来不就是个分类问题了么？对！同理，分类问题的常用处理手段之一就是回归花，比如你现在要做一个分类问题，天气情况，听上去挺困难的吧，但是如果你可以构造一个指标，这个指标本身是个连续的变量，那么你只需要考虑一系列的阈值就可以将天气情况的分类问题转为了，回归问题啦！当然这样的操作方法还有个大名鼎鼎的名字：[逻辑回归](https://en.wikipedia.org/wiki/Logistic_regression)！

最后我们再从直观上给出一个例子，来感受一些回归与分类这对孪生兄弟的异同：

![Classification VS Regression](D:\OneDrive\zhihu_writing\class-regress.png)

比如这里的分类，我们简单的用气温和湿度去考察天气情况，这里再简单起见，我们只考虑二分类binary，即下雨和不下雨。相应的这里的回归，我们考察的是温度与湿度之间的关系。总结来说：

> 分类：在我们的数据集上去寻找一个边界来区分下雨与不下雨，目的是对未来任意给定的点（气温湿度）去判断其天气状况（下雨和不下雨）。

> 回归：此处的回归考察是温度和湿度关系，即在我们的数据集上去寻找最“恰当”的一条曲线去刻画温度和湿度关系，目的是对未来任意给定湿度（或者气温），我们可以对气温（或者湿度）进行预测判断或者分析。



## 聚类与分类

其实作为监督学习的分类classification，在隔壁村还有个长得非常像的兄弟，叫聚类Clustering，聚类所在的村子是非监督unsupervised学习。之所以说他们很像，是因为他们的目标都是得出“标签”的类别，只不过他们所在的村子经济状况不同，监督学习的比较富裕，手中是有数据“标签”的，所以它可以通过这些已有的”标签“与预测未知的”标签“类别。相比之下，非监督学习就比较穷困了，手里有的数据都是歪瓜裂枣，完全没有给出一点”标签“的信息，所以作为生在非监督学习的聚类分析，只能通过全盘分析手中的数据，试图得到其数据的”特征“，然后根据这个自己辛辛苦苦总结分析出来的数据”特征“，将手里的数据分成一个个类别，不过此时，聚类分析的就体现了自己的优势，即可以给这些分好的类别贴上任意自己喜欢的标签啦！这听上去也好像还是蛮物超所值的嘛！

当然啦，一分耕耘一份收获，这里问题就在于这个“特征”，毕竟“特征”是个虚无缥缈的东西，想要获得，难度也不小哦！

还是举刚才例子来说，分类就是上面的图中的分类，而聚类其实就是将上面分类过程中点的“标签”去掉，目的仍然是想要得到一个区分两部分点的一个边界。

怎么样，直观上就可以看出其实聚类真的比分类要复杂的吧！



## 类别表示与分类器

抛开所有已知识，你试想一下，现在你有了很多天气数据， 那么首要问题是如何对该问题进行表示呢？比如天气情况，假定现在有晴，多云，阴，雨，雪五种情况，那么我们到底该如何表示才能方便我们开始建模呢？

1. *直接用1,2,3,4,5表示对应的晴，多云，阴，雨，雪*。这种表示的好处是简单，非常简单，也方便理解。但是有一个问题是，对于复杂的问题的解决就有些麻烦了，比如实际天气可能有雨夹雪，此时我们就不得不用两个数字{4,5}来表示这个数据了，但是这样就带来了一个极其严重的问题：数据格式不统一，即有些数据点是用一个数字表示的，而有些数据点使用2个甚至更多的数字表示的，这样将会给之后的建模造成诸多的困难。

2. *用一个向量表示*。这个就好比我们将数从实数推广到更高级别的复数而构造的<img src="https://www.zhihu.com/equation?tex=a + b i" alt="a + b i" class="ee_img tr_noresize" eeimg="1">的形式，并且我们用一个点对来表示任意一个复数。此时，在这里我们也可以同样采用这种方法，即用

   (1,0,0,0,0)来表示晴，

   (0,1,0,0,0)来表示多云,

   (0,0,1,0,0)来表示阴,

   (0,0,0,1,0)来表示雨，

   (0,0,0,0,1)来表示雪。

   乍一看，或许你会觉得，怎么你把一个简单问题复杂化了呀？其实不然，这表示虽然看上去复杂，但是变化多端及其便于我们建立之后的各种数学模型，并且它还能够考虑各种情况，比如刚才说的雨夹雪天气，那么我们就直接可以用(0,0,0,1,1)来表示。所以这种表示方法有种二进制感觉哦，即有多少的类别就建立相应大小的向量，然后其中1表示该类别是，0则为否。



Okay，现在我们搞明白了这个标签的表示，那么我们该如何去进行分类，构造所谓的分类器呢？

嗯~ o(*￣▽￣*)o 啊~呀

“之前你不是说了么，构造一个基于自变量的指标，然后根据这个指标设定不同的阈值，然后自然类别就出来了呀！”

Bingo，回答正确！

可是我们该如何去构造这个神奇的指标呢？

聪明的你或许直接就会想到，用上面的直线呀！

![correct](D:\OneDrive\zhihu_writing\correct-mark-hi.png)

针对上面气温湿度与天气状况的分类问题，根据示意图，我们可以自然而然想到，只要“适当”画一条线就好了呀。简单一点的话，就是条直线，想要精确一点那就画条曲线就好了呀！

对，你已经明白了大概！

继续网下想，有没有更好的方案呢？毕竟现在二分类，要是类别多了呢？我们能不能有更进一步想法呢？

概率！

对，我们事实上可以将每一个点附上概率，point marked probability，即每一个点我们都有给出它属于各个类别的概率，那么最终我们其实只要挑出其中概率最大的点，然后大声说：

“我的分类器 可以计算出这个气温湿度最大概率是下雨天，balabala！”听上去似乎很专业哦，有木有！！！

另外，由于概率都是落在（0，1）之间的，这样也非常便于我们的观察，棒棒哒，有木有！！！

因此，在这个框架下，我们最重要的就是计算出其属于各个类别的predictive distribution了哈！事实上这样的分类架构我们称作是概率化分类probabilistic classification，这也是我们之后主要将要讨论的分类架构哦！



简单，直观的说明就到这里啦，后面将有大波公式来临哦，前方高能，最好准备！

## 概率化分类

说到概率，一定要好好回忆一下我们之前讲过的一些内容和名词哦，比如密度函数，概率分布函数，联合密度函数，条件密度函数等等，如果忘记了，记得回去好好复习哦！！！

上一节说到各个类别的分布，仔细想来是不是这个联合（密度）概率，

<img src="https://www.zhihu.com/equation?tex=p(y,x)" alt="p(y,x)" class="ee_img tr_noresize" eeimg="1">

呢？其中<img src="https://www.zhihu.com/equation?tex=y" alt="y" class="ee_img tr_noresize" eeimg="1">是我们的类别标签，<img src="https://www.zhihu.com/equation?tex=x" alt="x" class="ee_img tr_noresize" eeimg="1">是这里的自变量，比如天气预报例子中的气温，气压等等。既然是联合（密度）概率，根据贝叶斯定理，

什么？贝叶斯定理都不记得了呀！来人哪，50大板，然后赶紧回去复习贝叶斯公式，先验，后验，似然等等！！！

利用贝叶斯定理，我们可以将这个联合（密度）概率可以表示成为<img src="https://www.zhihu.com/equation?tex=p(y)p(x|y)" alt="p(y)p(x|y)" class="ee_img tr_noresize" eeimg="1">或者<img src="https://www.zhihu.com/equation?tex=p(x)p(y|x)" alt="p(x)p(y|x)" class="ee_img tr_noresize" eeimg="1">，因而这里又可以有两者不同方式去处理这个概率化分类：

1. 通过<img src="https://www.zhihu.com/equation?tex=p(y)p(x|y)" alt="p(y)p(x|y)" class="ee_img tr_noresize" eeimg="1">，叫做generative approach。它的本质是，我们知道一些关于class的信息，即<img src="https://www.zhihu.com/equation?tex=p(y)" alt="p(y)" class="ee_img tr_noresize" eeimg="1"> 对于<img src="https://www.zhihu.com/equation?tex=y=C_1, C_2, \cdots, C_C" alt="y=C_1, C_2, \cdots, C_C" class="ee_img tr_noresize" eeimg="1">，而我们需要设法知道class-conditional distribution，<img src="https://www.zhihu.com/equation?tex=p(x|y)" alt="p(x|y)" class="ee_img tr_noresize" eeimg="1">， 然后我们就可以得到关于每一个class的后验分布，即
   
<img src="https://www.zhihu.com/equation?tex=   p(y|x) = \frac{p(y)p(x|y)}{\sum_{c=1}^C p(C_c)p(x|C_c)}.
   " alt="   p(y|x) = \frac{p(y)p(x|y)}{\sum_{c=1}^C p(C_c)p(x|C_c)}.
   " class="ee_img tr_noresize" eeimg="1">

   这个方法也被Dawid称作是sampling paradigms。

2. 直接考虑<img src="https://www.zhihu.com/equation?tex=p(y|x)" alt="p(y|x)" class="ee_img tr_noresize" eeimg="1">，叫做discriminative approach。也叫被Dawid称作是diagnostic paradigms。

当然，无论是哪一种，都需要考虑条件概率<img src="https://www.zhihu.com/equation?tex=p(x|y)" alt="p(x|y)" class="ee_img tr_noresize" eeimg="1">或者<img src="https://www.zhihu.com/equation?tex=p(y|x)" alt="p(y|x)" class="ee_img tr_noresize" eeimg="1">，只不过对于generative的方法来说相对简单一些，因为<img src="https://www.zhihu.com/equation?tex=p(y)" alt="p(y)" class="ee_img tr_noresize" eeimg="1">可以直接被计算，binomial概率就是binary的形式，multinomial概率就是就是multi-class的情况。事实上，对于generative approach，常用的class-conditional的密度设置是高斯的哈，即

<img src="https://www.zhihu.com/equation?tex=p(x|C_c) = \mathcal{N}(\mu_c, \Sigma_c)." alt="p(x|C_c) = \mathcal{N}(\mu_c, \Sigma_c)." class="ee_img tr_noresize" eeimg="1">

不过这里值得注意的是，因为我们放了高斯的class-conditional假设，倘若最终数据不满足，那模型估计也是出不了什么好的结果啦！



刚才说到，一般情况下相对于generative approach，discriminative approach显得要复杂很多，不过具体问题具体分析，对于binary的discriminative问题，有一个简便方法，即采用response function （也叫做inverse of a link function, [logistic function](https://en.wikipedia.org/wiki/Logistic_function), [sigmoid](https://en.wikipedia.org/wiki/Sigmoid_function)）将原模型产生的输入扔进一个概率回归模型中。这样的最大好处就是可以将一个原本变化范围再<img src="https://www.zhihu.com/equation?tex=(-\infty, \infty)" alt="(-\infty, \infty)" class="ee_img tr_noresize" eeimg="1">的量放到[0,1]之间，这样我们就可以用概率去解释了哦！

一个大家或许熟知的例子就是，linear logistic regression模型

<img src="https://www.zhihu.com/equation?tex=p(C_1|x) = \lambda(X^Tw), \mbox{where}, \lambda(z) = \frac{1}{1 + \exp(-z)}." alt="p(C_1|x) = \lambda(X^Tw), \mbox{where}, \lambda(z) = \frac{1}{1 + \exp(-z)}." class="ee_img tr_noresize" eeimg="1">

当然这个模型本身就是linear模型复合上了logistic response function。这个就是大名鼎鼎的logistic函数。

![logistic function](D:\OneDrive\zhihu_writing\logistic.png)

当然如果你试着回忆下还有一个函数长得跟这个非常类似，它就是标准正态分布的累计密度函数，

<img src="https://www.zhihu.com/equation?tex=\Phi(x) = \int_{-\infty}^z \mathcal{N}(x|0,1)dx," alt="\Phi(x) = \int_{-\infty}^z \mathcal{N}(x|0,1)dx," class="ee_img tr_noresize" eeimg="1">

对应这个的回归还有个新的名字，叫[probit regression](https://en.wikipedia.org/wiki/Probit_model)。其实无论是logistic regression还是probit regression都已经是大名鼎鼎，这里就不在介绍具体了，不过其中的logistic之后在我们导出高斯过程分类的过程中还需要反复提到的哦！



刚才说到两种approaches，generative approach和discriminative，自然聪明的你就会直接开问：

**到底我该选择谁**？ 

![Left or Right?](D:\OneDrive\zhihu_writing\leftandright.jpeg)

这是个大问题，没有一个标准答案，但是我们分析在各种情况下，两者的优劣：

* Discriminative approach直接，粗暴，直击要害，而generative approach还需要计算class-conditional distribution，通常情况，这个分布的估计并不容易，尤其是当x自身是高维度的时候。所以如果我们仅仅关注分类问题本身，不涉及其他，那么generative方法算的很辛苦很艰难，然而事实上却算了很多我们并不需要的东西。
* 在我们面临复杂问题的时候，比如输入的缺失，outlier或者是标签的缺失的话，如果我们可以知道<img src="https://www.zhihu.com/equation?tex=p(x)" alt="p(x)" class="ee_img tr_noresize" eeimg="1">的信息，这将会是极好的哈！在generative approach， 它并且它可以通过<img src="https://www.zhihu.com/equation?tex=p(x) = \sum_{y}p(y)p(x|y)" alt="p(x) = \sum_{y}p(y)p(x|y)" class="ee_img tr_noresize" eeimg="1"> 计算。
* 至于选择方式么，之前说了Discriminative approach与Generative approach两者有不同的所需信息，若是数据信息中已经有了相关的先验，那么就可以根据相关的先验选择合适的方法啦！



说到这里，各种预备知识应该都准备的差不多了吧，下面我们要开始我们的正题了哈！

## 高斯过程分类

记得在这个专栏开始的时候就说过，这个高斯过程GP是个强大的方法，它不光可以处理回归问题当然也可以处理分类问题，可用一句话形容GP：

> 两手都可以抓，两手都非常硬！

有了之前的预备只是，或许你真的会发现GPR与GPC只有一线之隔哦！同样的配方，同样的方法，唯一不同就是output。因为我们可以发现，如果仿照刚才的linear model+logistic function = linear logistic model，可以被用来走classification的话，那么对于GPC则是，在GPR的基础上，再走一步，将这个GPR得到的output，通过*适合*的S型response函数获得相应的class probability，这样一来高斯过程分类就是可以搞定了么！用一张流程图来表示这个操作就是：

![GPC-Operation](D:\OneDrive\zhihu_writing\gpc_process.png)



对于GPR来说，output直接扔出来就好了呀，而GPC则需要在走一步，将这个output通过适合的S型response函数获得相应的class probability。



好啦，今天这节基础知识就回顾的差不多了哦，下一节我们将从linear的分类模型，途径logistic regression模型，一步步导出我们的主题：

**高斯过程分类**

![Coming soon](D:\OneDrive\zhihu_writing\COMING+SOON.jpg)