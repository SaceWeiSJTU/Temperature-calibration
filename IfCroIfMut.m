%�ж��Ŵ������Ƿ���Ҫ���н�������
function pcc=IfCroIfMut(mutORcro)
test(1:100)=0;
L=round(100*mutORcro);
test(1:L)=1;
n=round(rand*99)+1;
pcc=test(n);