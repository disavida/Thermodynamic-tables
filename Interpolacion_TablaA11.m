%%Tabla A11
%David Umaña
%Este script interpola los datos de la tabla A11 de Termodinámica de Cengel
%para encontrar los datos de Presión de saturación, Volumen específico,
%energía interna específica, entalpía específica y entropía específica del
%refrigrerante 134a
clc; clear all; close all;
Tabla = readtable("Tablas\TablaA11.txt", "PreserveVariableNames", 1);
Tabla = table2array(Tabla);
options =  {"Presión Sat.", "Volumen Líq. Sat. (vf)", "Volumen de Vap. Sat. (vg)", "Energía interna Líq. Sat. (uf)", "Energía interna Vap. Sat. (ug)", "Entalpía Líq. Sat. (hf)", "Entalpía Vap. Sat. (hg)", "Entropía Líq. Sat. (sf)", "Entropía Vap. Sat. (sg)"};
s3 =  {"Presi\'on Sat.", "Volumen L\'iq. Sat.", "Volumen de Vap. Sat.", "Energ\'ia interna L\'iq. Sat.", "Energ\'ia interna Vap. Sat.", "Entalp\'ia L\'iq. Sat.", "Entalp\'ia Vap. Sat.", "Entrop\'ia L\'iq. Sat.", "Entrop\'ia Vap. Sat."};
choice = menu('Seleccione la propiedad a interpolar',options);
switch choice
    case 1 %Presión
      x = 2;
      s2 = "kPa";
      s4 = "kPa";
      title1 = "Gr\'afico T vs P";
    case 2 %Volumen Líq. Sat. (vf)
      x = 3;
      s2 = "$\frac{m^3}{kg}$";
      title1 = strcat("Gr\'afico T vs"," $v_f$");
      s4 = "m^3/kg";
    case 3 %Volumen de Vap. Sat. (vg)
      x = 4;
       s2 = "$\frac{m^3}{kg}$";
       title1 = strcat("Gr\'afico T vs"," $v_g$");
       s4 = "m^3/kg";
    case 4 %Energía interna Líq. Sat. (uf)
      x = 5;
       s2 = "$\frac{kJ}{kg}$";
       title1 = strcat("Gr\'afico T vs"," $u_f$");
       s4 = "kJ/kg";
    case 5 %Energía interna Vap. Sat. (ug)
      x = 7;
      s2 = "$\frac{kJ}{kg}$";
      title1 = strcat("Gr\'afico T vs"," $v_g$");
      s4 = "kJ/kg";
    case 6 %Entalpía Líq. Sat. (hf)
      x = 8;
      s2 = "$\frac{kJ}{kg}$";
      title1 = strcat("Gr\'afico T vs"," $h_f$");
      s4 = "kJ/kg";
    case  7 %Entalpía Vap. Sat. (hg)
      x = 10;
      s2 = "$\frac{kJ}{kg}$";
      title1 = strcat("Gr\'afico T vs"," $h_g$");
      s4 = "kJ/kg";
    case 8 %Entropía Líq. Sat. (sf)
      x = 11;
      s2 = "$\frac{kJ}{kg}$";
      title1 = strcat("Gr\'afico T vs"," $s_f$");
      s4 = "kJ/kg";
    case 9 %Entropía Vap. Sat. (sg)
      x = 13;
      s2 = "$\frac{kJ}{kg}$";
      title1 = strcat("Gr\'afico T vs"," $v_g$");
      s4 = "kJ/kg";
end

X = Tabla(1:end, 1);
Y = Tabla(1:end, x);
u = input("Temperatura de entrada (°C): ");

s1 = string(options(choice));
s3 = string(s3(choice));
interpolant = griddedInterpolant(X,Y, 'linear');
interp = interpolant(u);

%%
%Grafico
newXSamplePoints = min(X):0.1:max(X);
smoothedY = interpolant(newXSamplePoints);
% Plot smoothedY and show how the line is
% smooth, and has no sharp bends.
plot = plot(smoothedY, newXSamplePoints);
title(title1, "Interpreter", "latex", "FontSize", 15);
hold on
plot2 = scatter(interp, u, "ob");
%%Crea un data tip
plot2.DataTipTemplate.DataTipRows(1).Label = strcat(s3,"(",s2,")" ,":"); 'Interpreter'; 'latex'; %Asigna nombre al valor x
plot2.DataTipTemplate.DataTipRows(2).Label = 'Temperatura (Celcius):';'Interpreter'; 'latex'; %Asigna nombre al valor y
dt = datatip(plot2,u, interp, 'Interpreter', 'latex');%Ingresa el punto mediante el método
%% Graphic Current Axes
a = gca;
a.TickLabelInterpreter = "latex";
%interestpoint = datatip(plot2, u, interp);
%%
y1 =strcat(s3," (",s2,")");
x1 = "Temperatura (Celcius)";
xlabel(y1, 'Interpreter', 'latex');
ylabel(x1','Interpreter', 'latex');
xlim([min(Y) max(Y)]);
hold off
%%
%Resultado
resultado = strcat(s1," : ", num2str(interp)," ",  s4);
disp(" ");
disp(resultado)