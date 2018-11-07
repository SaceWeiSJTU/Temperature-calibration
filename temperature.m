tic
global Bitlength
global truetablelist
global costofmea %����һ���ĳɱ�
global popsize
Bitlength=90; %���볤��
%ֱ�Ӷ����ļ�
truetablelist=csvread('dataform20160902.csv');
popsize=150; %��ʼ��Ⱥ�Ĵ�С
costofmea=50;%����һ���¶�ֵ�ĳɱ�Ϊ50
Generationmax=2;    %������
pcrossover=0.95;     %�������
pmutation=0.05;      %�������
%������ʼ��Ⱥ
population=round(rand(popsize,Bitlength)-0.2);
%������Ӧ�ȣ�����ֵΪ��Ӧ��fitvalue�ͻ��۸���cumsump
[fitvalue,cumsump]=fitnessfun(population);
Generation=1;
while Generation<Generationmax+1
    for j=1:2:popsize
        %ѡ�����
        seln=selection(cumsump);
        %�������
        scro=crossover(population,seln,pcrossover);
        scnew(j,:)=scro(1,:);
        scnew(j+1,:)=scro(2,:);
        %�������
        smnew(j,:)=mutation(scnew(j,:),pmutation);
        smnew(j+1,:)=mutation(scnew(j+1,:),pmutation);
    end
    population=smnew;   %��������Ⱥ
    %��������Ⱥ����Ӧ��
    [fitvalue,cumsump]=fitnessfun(population);
    %��¼��ǰ����õ���Ӧ�Ⱥ�ƽ����Ӧ��
    [fmax,nmax]=max(fitvalue);
    fmean=mean(fitvalue);
    ymax(Generation)=1/fmax;  %�˴�������Ǹô����ųɱ�
    ymean(Generation)=1/fmean;%����ƽ�����ųɱ�
    %��¼��ǰ�������Ⱦɫ��
    unit=population(nmax,:);
    xmax=zeros(Generationmax,Bitlength);
    xmax(Generation,:)=unit;
    Generation=Generation+1;
end

toc

Generation=Generation-1;
bestpopulation=unit;
bestvalue=ymax(Generation);
finaltesttable=[];
for i=1:Bitlength
    if unit(i)==1
        finaltesttable(end+1)=i-21;
    end
end
disp('The final data we choose is:');
disp(finaltesttable);
disp('The final cost is:');
disp(bestvalue);

figure(1);
hand1=plot(1:Generation,ymax);
set(hand1,'linestyle','-','linewidth',1.8,'marker','*','markersize',6)
hold on;
hand2=plot(1:Generation,ymean);
set(hand2,'color','r','linestyle','-','linewidth',1.8,'marker','h',...
    'markersize',6)
xlabel('��������');ylabel('����/ƽ���ɱ�ֵ');xlim([1 Generationmax]);
legend('���ųɱ�','ƽ���ɱ�');
hold off;
