%Heat Equation 2D - Cas homogène | Régime permanent | Sans source interne
%| Méthode différences finis | Code fonctionne de préférence avec plaque
%carré L = 3

clear all
clc

%Plaque plane rectangulaire

%Données
N = 4; %Discrétisation (faire en sorte que h C |N) => taille matrice
ax = 0;
bx = 4;
Lx = ax - bx; %Longueur de la plaque en m
ay = 0;
by = 4;
Ly = ay - by; %Largeur de la plaque en m
hx = Lx/N; %Approximation obtenir par DF d'ordre 2 suivant x
hy = Ly/N; %Approximation obtenir par DF d'ordre 2 suivant y
T1 = 100; %Température à la limite 1 de la plaque en K
T2 = 200; %Température à la limite 2 de la plaque en K
T3 = 300; %Température à la limite 3 de la plaque en K
T4 = 400; %Température à la limite 4 de la plaque en K

%L'équation de la chaleur, dans ce cas, s'écrit comme suit :
% DT = d²T/dx² + d²T/dy² =0

%Représentation analytique de d²T/dx² et d²T/dy²
%d²T/dx² = (T(i+1,j)-2*T(i,j)+T(i-1,j))/(hx)^2
%d²T/dy² = (T(i,j+1)-2*T(i,j)+T(i,j-1))/(hy)^2

%DT = 0 en numérique
%M . T = f

%Initilisation de M

T = zeros(N,N); %Initiation du maillage température
for i = 1:N
    T(i,1) = T1;
end
for i = 1:N
    T(i,N) = T2;
end
for j = 1:N
    T(1,j) = T3;
end
for j = 1:N
    T(N,j) = T4;
end
T(1,1) = (T1+T3)/2;
T(N,1) = (T1+T4)/2;
T(1,N) = (T3+T2)/2;
T(N,N) = (T2+T4)/2;

A1 = -2*(hx*hx + hy*hy)*eye(2) - hy*hy*eye(2);
A = A1 + hy*hy;

B = eye(2)*hx*hx;

M = [A B ; B A];

f = zeros(N,1);
f(1,1) = hy*hy*T(1,2) + hx*hx*T(2,1);
f(2,1) = hx*hx*T(3,1) + hy*hy*T(N,1);
f(3,1) = hy*hy*T(1,3) + hx*hx*T(2,N);
f(4,1) = hy*hy*T(N,3) + hx*hx*T(3,N);

U = zeros(N,1);

U = -inv(M)*f;

T(2,2) = U(1,1);
T(3,2) = U(2,1);
T(2,3) = U(3,1);
T(3,3) = U(4,1);

contourf(T)
    