# Gaussian process classification�����ܡ����ع��������ʵֻ��һ��֮��

���ñ�Ҷ˹�������ǿ��Խ�������ϣ��ܶȣ����ʿ��Ա�ʾ��Ϊ<img src="https://www.zhihu.com/equation?tex=p(y)p(x|y)" alt="p(y)p(x|y)" class="ee_img tr_noresize" eeimg="1">����<img src="https://www.zhihu.com/equation?tex=p(x)p(y|x)" alt="p(x)p(y|x)" class="ee_img tr_noresize" eeimg="1">����������ֿ��������߲�ͬ��ʽȥ����������ʻ����ࣺ

1. ͨ��<img src="https://www.zhihu.com/equation?tex=p(y)p(x|y)" alt="p(y)p(x|y)" class="ee_img tr_noresize" eeimg="1">������generative approach�����ı����ǣ�����֪��һЩ����class����Ϣ����<img src="https://www.zhihu.com/equation?tex=p(y)" alt="p(y)" class="ee_img tr_noresize" eeimg="1"> ����<img src="https://www.zhihu.com/equation?tex=y=C_1, C_2, \cdots, C_C" alt="y=C_1, C_2, \cdots, C_C" class="ee_img tr_noresize" eeimg="1">����������Ҫ�跨֪��class-conditional distribution��<img src="https://www.zhihu.com/equation?tex=p(x|y)" alt="p(x|y)" class="ee_img tr_noresize" eeimg="1">�� Ȼ�����ǾͿ��Եõ�����ÿһ��class�ĺ���ֲ�����
   

<img src="https://www.zhihu.com/equation?tex=   p(y|x) = \frac{p(y)p(x|y)}{\sum_{c=1}^C p(C_c)p(x|C_c)}.
   " alt="   p(y|x) = \frac{p(y)p(x|y)}{\sum_{c=1}^C p(C_c)p(x|C_c)}.
   " class="ee_img tr_noresize" eeimg="1">

   �������Ҳ��Dawid������sampling paradigms��

2. ֱ�ӿ���<img src="https://www.zhihu.com/equation?tex=p(y|x)" alt="p(y|x)" class="ee_img tr_noresize" eeimg="1">������discriminative approach��Ҳ�б�Dawid������diagnostic paradigms��

