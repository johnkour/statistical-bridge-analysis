function [dsp,N]= solveStructure(nodes,element,NodalLoads,constraints)

nel=length(element);
nnod=size(nodes,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ftiaxe to index table
index=ones(nnod,2);
for n = 1:size(constraints,1)
    inode = constraints(n,1);
    if constraints(n,2) == 1;
        index(inode ,1) = 0;
    end
    if constraints(n,3) == 1;
        index(inode ,2) = 0;
    end
end

ndof = sum(sum(index==1));

icount=0;
for i=1:size(index,1)
    for j=1:2
        if index(i,j)==1
            icount=icount+1;
            index(i,j)=icount;
        end
    end;
end;

% Create local stiffness matrix.Enter the transformation matrix and create
% the total global stiffness matrix
K_gl=zeros(ndof);
for n=1:nel
    
    [~,K_gl_el,eldof{n}] = truss('stiffness',n,element{n},nodes,index);
        
    % ASSEMBLE THE GLOBAL STIFFNESS MATRIX
    ff=find(eldof{n}~=0);
    cc=find(eldof{n}==0);
    K_gl(eldof{n}(ff),eldof{n}(ff)) = K_gl(eldof{n}(ff),eldof{n}(ff)) + K_gl_el(ff,ff);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mitrwo akampsias me energous dof

%%%%%%%%%%%%%%%%%%%%%%%%%%% NODAL LOADS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ndim=size(NodalLoads,2)-1;
Fg = zeros(ndof,1);
for i=1:size(NodalLoads,1)
    for j=2:(ndim+1)
        ip=index(NodalLoads(i,1),j-1);
        if ip~=0
            Fg(ip,1)=NodalLoads(i,j);
        end
    end;
end;

% load('exaData')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SOLVE
u = K_gl\Fg;


% displacements per node
dsp = zeros(size(nodes,1),2);
for i = 1:nnod
    idof = index(i,:);
    for j=1:2
        if idof(j)>0
            dsp(i,j) = u(idof(j));
        end
    end
end

% get forces
for n = 1:nel
    udisp = zeros(4,1);
    for i=1:4
        if eldof{n}(i)~=0  udisp(i) = u(eldof{n}(i)); end
    end
    [N_lc{n}] = truss('forces',n,element{n},nodes,index,udisp);
    N(n,1) = -N_lc{n}(1);
end


end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function [K_loc,K_gl_el,eldof] = truss(icase,n,elements,nodes,index,udisp_g)

% ELASTIC 2D truss
Node_i = elements{2};  %Start node
Node_j = elements{3};  %End  node

Xi= nodes(Node_i,1);     %Start Node - X Coordinate
Xj= nodes(Node_j,1);     %End Node - X Coordinate
Yi= nodes(Node_i,2);     %Start Node - Y Coordinate
Yj= nodes(Node_j,2);     %End Node - Y Coordinate

eldof = [ index(Node_i,:) index(Node_j,:)];

E = elements{4};       % na apofeugeis metablites me ena gramma
A = elements{5};

L = sqrt((Xj-Xi)*(Xj-Xi) + (Yj-Yi)*(Yj-Yi));
Dx = Xj - Xi ;
Dy = Yj - Yi ;

cosf = Dx/L;
sinf = Dy/L;

T = [cosf  sinf  0   0;
    -sinf  cosf  0   0;
    0     0   cosf sinf;
    0     0  -sinf cosf];

K_loc = [ E*A/L  0  -E*A/L   0;
    0   0     0     0;
    -E*A/L  0   E*A/L   0
    0   0     0     0];

if strcmp(icase,'stiffness')
    
    K_gl_el = T'* K_loc * T ;
    
elseif strcmp(icase,'forces')
    
%     udisp = T*udisp_g;
    
    K_gl_el_Tmp = T'* K_loc * T ;
    K_gl_el = K_gl_el_Tmp*udisp_g;  % auta einai dunameis, oxi K
    
    udisp = T*udisp_g;
    K_loc = K_loc*udisp; % auta einai dunameis, oxi K
    
end;

end
