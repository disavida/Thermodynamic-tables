%Tabla A12
%David Umaña
%Este script interpola los datos de la tabla A12 de Termodinámica de Cengel
%para encontrar los datos de temperatura de saturación, Volumen específico,
%energía interna específica, entalpía específica y entropía específica del
%refrigrerante 134a
clc; clear all; close all;
Tabla = table2array(readtable("Tablas\TablaA12.txt", "PreserveVariableNames", 1));
options =  {"Temperatura (°C)", "Volumen Líq. Sat. (vf)", "Volumen de Vap. Sat. (vg)", "Energía interna Líq. Sat. (uf)", "Energía interna Vap. Sat. (ug)", "Entalpía Líq. Sat. (hf)", "Entalpía Vap. Sat. (hg)", "Entropía Líq. Sat. (sf)", "Entropía Vap. Sat. (sf)"};

choice = menu('Seleccione la propiedad a interpolar',options);
switch choice
    case 1 %Presión
      x = 2;
      s2 = "(°C)";
    case 2 %Volumen Líq. Sat. (vf)
      x = 3;
      s2 = "m^3/kg";
    case 3 %Volumen de Vap. Sat. (vg)
      x = 4;
       s2 = "m^3/kg";
    case 4 %Energía interna Líq. Sat. (uf)
      x = 5;
       s2 = "kJ/kg";
    case 5 %Energía interna Vap. Sat. (ug)
      x = 7;
      s2 = "kJ/kg";
    case 6 %Entalpía Líq. Sat. (hf)
      x = 8;
      s2 = "kJ/kg";
    case  7 %Entalpía Vap. Sat. (hg)
      x = 10;
      s2 = "kJ/kg";
    case 8 %Entropía Líq. Sat. (sf)
      x = 11;
      s2 = "kJ/kg";
    case 9 %Entropía Vap. Sat. (sf)
      x = 13;
      s2 = "kJ/kg";
end

X = Tabla(1:end, 1);
Y = Tabla(1:end, x);
u = input("Presión de entrada (kPa): ");

s1 = string(options(choice));
interp = interp1(X,Y,u, 'spline');

newXSamplePoints = min(X):0.01:max(X);
smoothedY = spline(X, Y, newXSamplePoints);
% Plot smoothedY and show how the line is
% smooth, and has no sharp bends.
plot = plot(newXSamplePoints, smoothedY);
hold on
plot2 = scatter(u, interp, "ob");
interestpoint = datatip(plot2, u, interp);
resultado = strcat(s1," : ", num2str(interp)," ",  s2);
disp(" ");
disp(resultado)