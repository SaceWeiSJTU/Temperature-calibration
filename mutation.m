%����Ⱥ�������
function smnew=mutation(snew,pmutation)
global Bitlength
smnew=snew;
pmm=IfCroIfMut(pmutation);  %���ݱ�����ʾ����Ƿ���б��������1Ϊ��
if pmm==1
    %��[1,Bitlength-1]���������һ������λ
    chb=round(rand*(Bitlength-1))+1;
    smnew(chb)=abs(snew(chb)-1);
end