%判断遗传运算是否需要进行交叉或变异
function pcc=IfCroIfMut(mutORcro)
test(1:100)=0;
L=round(100*mutORcro);
test(1:L)=1;
n=round(rand*99)+1;
pcc=test(n);