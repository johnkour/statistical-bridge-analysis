function [N_min, N_max] = thema(q, L, h, E, A1)
%TRUSS SOLVER
%   This function has inputs the load(q), the length of every opening(L)
%   and the height(h) of the truss. It also needs the elasticity
%   modulus(E) and the area of the default section(A1). This solver only
%   works for a specific geometry. After the analysis, the function returns
%   the minimum(N_min) and the maximum(N_max) of the axial forces of the
%   sections.

% NODAL COORDINATES  X,  Y,
nodes= [0   0
    L   0
    L   h
    2*L   0
    2*L   h
    3*L   0
    3*L   h
    4*L   0
    4*L   h
    5*L   0
    5*L   h
    6*L   0];

% ELEMENT PROPETIES
elements{1} = {'truss' 1  2   E  A1};
elements{2} = {'truss' 2  4   E  A1};
elements{3} = {'truss' 4  6   E  A1};
elements{4} = {'truss' 6  8   E  A1};
elements{5} = {'truss' 8  10  E  A1};
elements{6} = {'truss' 10 12  E  A1};

elements{7} = {'truss' 1  3   E  A1};
elements{8} = {'truss' 2  5   E  A1};
elements{9} = {'truss' 4  7   E  A1};
elements{10} = {'truss' 8  7   E  A1};
elements{11} = {'truss' 10  9  E  A1};
elements{12} = {'truss' 11 12  E  A1};

elements{13} = {'truss' 3   5   E  A1};
elements{14} = {'truss' 5  7   E  A1};
elements{15} = {'truss' 7  9   E  A1};
elements{16} = {'truss' 9  11  E  A1};

elements{17} = {'truss' 2  3   E  A1};
elements{18} = {'truss' 4  5   E  A1};
elements{19} = {'truss' 6  7   E  A1};
elements{20} = {'truss' 8  9  E  A1};
elements{21} = {'truss' 10 11  E  A1};

P = q*4*L/5; % katamimenop fortio q apo 4 anoigmata isomoirasmeno se 5 kombous
NodalLoads=[3 0 -P
    5 0 -P
    7 0 -P
    9 0 -P
    11 0 -P];

bcon=[1  1  1 ;
    12  1  1 ];

PlotFrame(nodes,elements,bcon,'labels')
axis equal
grid off

% Dpl = displacements = metakinhseis
% Naxial = element xial forces = aksonikes melwn
[Dpl, axial] = solveStructure(nodes,elements,NodalLoads,bcon);

PlotFrame(nodes,elements,bcon,'disp',Dpl*100)
axis equal

N_max = max(axial);
N_min = min(axial);

end

