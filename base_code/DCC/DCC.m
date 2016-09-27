function [W,r] = DCC(data,label)

n_iter = 10; % number of iteration

% Setting param
[dim,num] = size(data); 
num_class = length(unique(label));
num_sets=num/num_class;
% Iterative optimization
W = eye(dim,dim); % Init.

for iter=1:n_iter
fprintf('\n iter %d \n',iter);
 
% Step-1: Normalize P
Po = DCC_Normal(data,W);

Sw = zeros(dim,dim); Sb = zeros(dim,dim);
V1 = zeros(dim,1); V2 = zeros(dim,1);
    
nw = 0; nb=0;
% Within-class sets
for k=1:num_class
    for set1=1:num_sets
        for set2=set1+1:num_sets
            V1(:,:) = Po(:,(k-1)*num_sets+(set1-1)+1:(k-1)*num_sets+(set1-1)+1); 
            V2(:,:) = Po(:,(k-1)*num_sets+(set2-1)+1:(k-1)*num_sets+(set2-1)+1); 
            
            % Step-2: Compute Rotating Matrices Q
            [can1, can2] = Get_CV(W,V1(:,1),V2(:,1));
                    
            dtemp = can1 - can2; Sdtemp = dtemp*dtemp';
            Sw = Sw + Sdtemp; nw = nw+1;
        end
    end
end % End of the loop for the Within-class sets

% Between-class sets
for k=1:num_class
    for j=k+1:num_class
        for set1=1:num_sets
            for set2=1:num_sets
            V1(:,:) = Po(:,(k-1)*num_sets+(set1-1)+1:(k-1)*num_sets+(set1-1)+1); 
            V2(:,:) = Po(:,(j-1)*num_sets+(set2-1)+1:(j-1)*num_sets+(set2-1)+1); 
            
            % Step-2 : Compute Rotating Matrices Q
            [can1, can2] = Get_CV(W,V1(:,1),V2(:,1));
        
            dtemp = can1 - can2; Sdtemp = dtemp*dtemp';
            Sb = Sb + Sdtemp; nb = nb+1;
            end
        end
    end
end % End of the loop for the Between-class sets


% Step-3 : Compute the discriminant transformation matrix T
Sdw = Sw/(nw); Sdb = Sb/(nb);
Sd = inv(Sdw)*Sdb;

% fprintf('log(det) :'); 
jdet(iter) = log(det(Sd));
if(iter>1)
    if(jdet(iter)<jdet(iter-1)) 
        break; 
    end
end

[V, D] = eig(Sd);
W = V; 
r=rank(Sd);

end % End of loop 'iter'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Get final T
% if(dims==dim) 
%     Tf = T;
% else % In the case of 'Dimension Reduction'
%     Tf = P*T;
% end


function P_temp = DCC_Normal(P,U)
    
M = size(P,2);
for i=1:M
    p = P(:,(i-1)+1:i);
    a = U'*p;
    [Q, R] = qr(a,0);
    
    for j=1:size(Q,2)
        if(Q(:,j)'*a(:,j)<0)
            R(j,:) = -R(j,:);
        end
    end

    p = p*inv(R);
    P_temp(:,(i-1)+1:i) = p;
end

function [can1,can2] = Get_CV(T,V_tr,V_te)

[Y,C,Z] = svd((T'*V_tr)'*(T'*V_te));
can1 = V_tr*Y;
can2 = V_te*Z;

