%Heat Equation 1D - Cas homog�ne | R�gime permanent | Sans source interne

clear all
clc

%Mur d�un four est compos� de 2 couches
%Hypoth�ses : -Pas de source interne -R�gime permanent -Probl�me 1D -Contact parfait

%Donn�es
e1 = 0.2; %Epaisseur du mur 1 en m
e2 = 0.1; %Epaisseur du mur 2 en m
K1 = 1.38; %Conductivit� thermique du mur 1 en W.m-1.K-1
K2 = 0.17; %Conductivit� thermique du mur 2 en W.m-1.K-1
Ti = 1923.15; %Temp�rature � l'int�rieur du four en K
Te = 298.15; %Temp�rature � l'exterieur du four en K
hi = 70; %Coefficient d'�change global � l'int�rieur du four en W.m-2.K-1
he = 10; %Coefficient d'�change global � l'ext�rieur du four en W.m-2.K-1
S = 1; %Surface unitaire (Calcul par unit� de surface et non S = 1m�)

%%Calcluer les pertes de chaleur du four par unit� de surface
%Analogie �leectrique : Ti -> Ri -> T1 -> R1 -> T12 -> R2 -> T2 -> Re ->Te
                        %Flux = DT/Req
%Calcul des r�sistances
Ri = 1/(hi*S);  %R�sistance de convection � l'int�rieur du four en K.W-1
R1 = e1/(K1*S); %R�sistance du mur 1 en K.W-1
R2 = e2/(K2*S); %R�sistance du mur 2 en K.W-1
Re = 1/(he*S); %R�sistance de convection � l'ext�rieur du four en K.W-1
Req = Ri + R1 + R2 + Re; %R�sitance �quivalente

F = (Ti-Te)/Req %Flux thermique ou pertes de chaleur en W

%%Calculer la temp�rature de la paroi int�rieure du four
%Le flux est constant : F = (DT/R)
                        %Ti - T1 = F * R1
T1 = Ti - F*Ri

%%Calculer la temp�rature de la paroi ext�rieure du four
%De m�me que pr�c�demment
T2 = Te + F*Re

%%Calculer la temp�rature de l�interface entre les deux couches de mat�riau
%De m�me que pr�c�demment
T12 = T2 + F*R2

%%Repr�senter sch�matiquement le profil de temp�rature depuis Ti jusqu�� Te
%(Voir le corrig� pour une meilleur repr�senatation de la courbe)
T = [Ti T1 T12 T2 Te];
X = [-10 0 e1 e1+e2 e1+e2+10];
plot(X,T)