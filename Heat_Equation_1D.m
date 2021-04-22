%Heat Equation 1D - Cas homogène | Régime permanent | Sans source interne

clear all
clc

%Mur d’un four est composé de 2 couches
%Hypothèses : -Pas de source interne -Régime permanent -Problème 1D -Contact parfait

%Données
e1 = 0.2; %Epaisseur du mur 1 en m
e2 = 0.1; %Epaisseur du mur 2 en m
K1 = 1.38; %Conductivité thermique du mur 1 en W.m-1.K-1
K2 = 0.17; %Conductivité thermique du mur 2 en W.m-1.K-1
Ti = 1923.15; %Température à l'intérieur du four en K
Te = 298.15; %Température à l'exterieur du four en K
hi = 70; %Coefficient d'échange global à l'intérieur du four en W.m-2.K-1
he = 10; %Coefficient d'échange global à l'extérieur du four en W.m-2.K-1
S = 1; %Surface unitaire (Calcul par unité de surface et non S = 1m²)

%%Calcluer les pertes de chaleur du four par unité de surface
%Analogie éleectrique : Ti -> Ri -> T1 -> R1 -> T12 -> R2 -> T2 -> Re ->Te
                        %Flux = DT/Req
%Calcul des résistances
Ri = 1/(hi*S);  %Résistance de convection à l'intérieur du four en K.W-1
R1 = e1/(K1*S); %Résistance du mur 1 en K.W-1
R2 = e2/(K2*S); %Résistance du mur 2 en K.W-1
Re = 1/(he*S); %Résistance de convection à l'extérieur du four en K.W-1
Req = Ri + R1 + R2 + Re; %Résitance équivalente

F = (Ti-Te)/Req %Flux thermique ou pertes de chaleur en W

%%Calculer la température de la paroi intérieure du four
%Le flux est constant : F = (DT/R)
                        %Ti - T1 = F * R1
T1 = Ti - F*Ri

%%Calculer la température de la paroi extérieure du four
%De même que précédemment
T2 = Te + F*Re

%%Calculer la température de l’interface entre les deux couches de matériau
%De même que précédemment
T12 = T2 + F*R2

%%Représenter schématiquement le profil de température depuis Ti jusqu’à Te
%(Voir le corrigé pour une meilleur représenatation de la courbe)
T = [Ti T1 T12 T2 Te];
X = [-10 0 e1 e1+e2 e1+e2+10];
plot(X,T)