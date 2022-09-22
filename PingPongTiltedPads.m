format long;

hold on

%declaration of all parameters
d = 2.0;
h_n = 0.1524;
h_l = 0.7260;
l = 2.7432;
x_0 = -1;
y_0 = 2;
v_x = 2;
v_y = 0;
g = 9.8;
t = [0.001:0.001:20];
t_e = t; %this is just a mathematical column matrix that is used for calculations, it resets to 0 every time there is a collision
o_b=0;
o_p1 = 4*pi/9;
o_p2 = 5*pi/9;
v=0;

for i = 1:length(t)
    %evolution of the coordinates using newtons laws and conidering the
    %only external force as gravity
    x(i) = x_0 + v_x*t_e(i);
    y(i) = y_0 + v_y*t_e(i) - 0.5*g*t_e(i)*t_e(i);
    E(i) = 0.5*(v_y - g*t_e(i))^2 + 0.5*v_x^2 + g*y(i);
    
    %BOARD COLLISION
    %the condition for hitting the board
    if y(i) <= 0 && abs(x(i)) <= 1.3716
        
        %if the ball hits the table on the same side it ends the round
        if x_0*x(i) > 0
            break %termination of round
        end
        
        %the reflection formula
        v_y = -1*(v_y-g*t_e(i));
        
        %resetting initial conditions and effective time array
        y_0 = 0;
        x_0 = x(i);
        for j = i:length(t)
            t_e(j) = t(j) - t(i);
        end
        
    end
    
    %LEFT PAD COLLISION
    %the condition for hitting the left pad
    %the equation reads y - tan(o_p1)*x +(tan(o_p1)*x_0) + y_0 [this defines tilt and position] 
    %and -x_0 - d*cos(o_p1) < x < -x_0 + d*cos(o_p1) [these 2 are for the size of the pad]
    %and y_0 - d*sin(o_p1) < y < y_0 + d*sin(o_p1)[these 2 are for the size of the pad]
    if y(i)-5.6713*x(i)-9.2787 > 0 && -1.5452 < x(i) && x(i) < -1.1979 && 0.5152 < y(i) && y(i) < 2.4848
       
        %calculation of the magnitude of the velocity and incident angle
        v = sqrt((v_y - g*t_e(i))^2 + v_x^2);
        o_b = atan((v_y - g*t_e(i))/v_x);
        
        %since inverse tan function only has outputs in -pi/2 to pi/2, the
        %block of code just below accounts for that 
        if v_x<0
            o_b = o_b + pi;
        end
       
        %the reflection formula 
        o_b = 2*o_p1 - o_b;
        
        %elastic collision leads to coservation of magnitude of momentum(velocity by extension)
        v_x = v*cos(o_b);
        v_y = v*sin(o_b);
        
        %resetting initial conditions and effective time array 
        x_0 = x(i);
        y_0 = y(i);
        for l= i:length(t)
            t_e(l) = t(l) - t(i);
        end  
    end
    
    %RIGHT PAD COLLISION
    %the condition for hitting the right pad
    %the equation reads y - tan(o_p2)*x +(tan(o_p2)*x_0) + y_0 [this defines tilt and position] 
    %and x_0 - |d*cos(o_p2)| < x < x_0 + |d*cos(o_p2)| [these 2 are for the size of the pad]
    %and y_0 - |d*sin(o_p2)| < y < y_0 + |d*sin(o_p2)|[these 2 are for the size of the pad]
    if y(i)+5.6713*x(i)-9.2787> 0 && 1.1979 < x(i) && x(i) < 1.5452 && 0.5152 < y(i) && y(i) < 2.4848
       
        %calculation of the magnitude of the velocity and incident angle
        v = sqrt((v_y - g*t_e(i))^2 + v_x^2);
        o_b = atan((v_y - g*t_e(i))/v_x);
        
        %since inverse tan function only has outputs in -pi/2 to pi/2, the
        %block of code just below accounts for that
        if v_x < 0
            o_b = o_b + pi;
        end
        
        %the reflection formula
        o_b = 2*o_p2 - o_b;
        
        %elastic collision leads to coservation of magnitude of momentum(velocity by extension)
        v_x = v*cos(o_b);
        v_y = v*sin(o_b);
        
        %resetting initial conditions and effective time array
        x_0 = x(i);
        y_0 = y(i);
        for k = i:length(t)
            t_e(k) = t(k) - t(i);
        end  
    end
    
    %NET COLLISION
    if abs(x(i)) < 0.005
        if y(i) <= h_n
            break %termination of round
        end
    end
    
    %GROUND COLLISION
    if y(i) < -1*h_l;
        break %termination of round
    end
end 

%plot of the trajectory
plot(x, y, '.r');