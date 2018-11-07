function [fitvalue,cumsump]=fitnessfun(population)
global Bitlength
global truetablelist
global costofmea
global popsize
testtable=[];
caltable=[];
fitvalue=zeros(popsize,1);
cumsump=zeros(popsize,1);
numberoftruevalue=size(truetablelist,1)/2;
sumcostofmea=zeros(popsize,1);%������ɱ�  mm 
sumcostofcal=zeros(popsize,1);%�궨���ɱ�
sumcost=zeros(popsize,1);%�ܳɱ�
fitvalue=zeros(popsize,1);%��Ӧ��ֵ
for i=1:popsize
    caltable=[];
    testtable=[];
    for k=1:Bitlength
        if population(i,k)==1
            testtable(end+1)=k-21;
        else
            caltable(end+1)=k-21;
        end
    end
    %�ⶨ�ܳɱ�
    sumcostofmea(i)=costofmea*size(testtable,2);
    for j=1:(numberoftruevalue)
        volcaltable=[];
        voltesttable=[];
        for h=1:size(testtable,2)
            voltesttable(end+1)=truetablelist(2*j,(testtable(h)+21));%�ǲ���Ӧ�øĳ�J��
        end
        for h=1:size(caltable,2)
            volcaltable(end+1)=truetablelist(2*j,(caltable(h)+21));
        end
        fitresult=interp1(voltesttable,testtable,volcaltable,'spline');
        deviationresult=abs(fitresult-caltable);
        %���궨�ܳɱ�
        anumberfortest=size(caltable,2);
        for l=1:(anumberfortest)
            if deviationresult(l)<=0.5
                sumcostofcal(i)=sumcostofcal(i)+0;
            elseif deviationresult(l)<=1.0
                sumcostofcal(i)=sumcostofcal(i)+1;
            elseif deviationresult(l)<=1.5
                sumcostofcal(i)=sumcostofcal(i)+5;
            elseif deviationresult(l)<=2.0
                sumcostofcal(i)=sumcostofcal(i)+10;
            else 
                sumcostofcal(i)=sumcostofcal(i)+10000;
            end
%               error05=sum(deviationresult<=0.5);
%               error10=sum(deviationresult<=1.0);
%               error15=sum(deviationresult<=1.5);
%               error20=sum(deviationresult<=2.0);
%               error30=sum(deviationresult>2);
%               sumcostofcal(i)=sumcostofcal(i)+error10-error05+5*(error15...
%                   -error10)+10*(error20-error15)+error30*10000;
        end
    end
    sumcostofcal(i)=sumcostofcal(i)/numberoftruevalue;%���ƽ��ֵ
    sumcost(i)=sumcostofmea(i)+sumcostofcal(i);%�ܳɱ�
    fitvalue(i)=1/sumcost(i);%��Ӧ�Ⱥ���ֵ
end
%����ѡ�����
fsum=sum(fitvalue);
Pperpopulation=fitvalue/fsum;
Pperpopulation_20=Pperpopulation.^20;
psum=sum(Pperpopulation_20);
Pperpopulation_20=Pperpopulation_20/psum;
%�����ۼƸ���
cumsump(1)=Pperpopulation_20(1);
for i = 2:popsize
    cumsump(i)=cumsump(i-1)+Pperpopulation_20(i);
end
fitvalue=fitvalue';
cumsump=cumsump';