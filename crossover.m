function scro=crossover(population,seln,pc)
global Bitlength
pcc=IfCroIfMut(pc);   %���ݽ�����ʾ����Ƿ���н��������1Ϊ��
if pcc==1
    %��[1,Bitlength-1]���������һ������λ
    chb=round(rand*(Bitlength-2))+1;
    scro(1,:)=[population(seln(1),1:chb) population(seln(2),chb+1:Bitlength)];
    scro(2,:)=[population(seln(2),1:chb) population(seln(1),chb+1:Bitlength)];
else
    scro(1,:)=population(seln(1),:);
    scro(2,:)=population(seln(2),:);
end