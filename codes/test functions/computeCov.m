function [cov,nonCovered]=computeCov(xmk,ymk,xch,ych,sR,rvpR)
% format long g
c=0;
nonCovered=[];
thresh=sR+rvpR;
adjaMat=zeros(length(xch),length(xmk));
for i=1:length(xch)
     p1=[xch(i) ych(i)];
    for j=1:length(xmk)
    p2=[xmk(j)  ymk(j)];
    adjaMat(i,j)=equlidianDist(p1,p2);
    end
end
for i=1:length(xch)
    if min(adjaMat(i,:))>thresh
        c=c+1;
        nonCovered=[nonCovered i];
    end
end    
cov=1-(c/length(xch));
end
    