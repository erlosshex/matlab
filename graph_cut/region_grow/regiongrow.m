function [g,NR,SI,TI]=regiongrow(f,S,T)
%REFIONGROW Perform segmentation by region growing.
f=double(f);
%If S is a scalar, obtain the seed image.
if numel(S)==1
    SI=f==S;
    S1=S;
else
    % S is an array. Eliminate duplicate, connect seed locations
    % to reduce the number of loop executions in the following
    % sections of code.
    SI=bwmorph(S,'shrink',Inf);
    J=find(SI);
    S1=f(J); % Array of seed value.
end
TI=false(size(f));
for K=1:length(S1)
    seedvalue=S1(K);
    S=abs(f-seedvalue)<=T;
    TI=TI|S;
end
[g,NR]=bwlabel(imreconstruct(SI,TI));