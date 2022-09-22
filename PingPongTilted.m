format long;

hold on

l = 2.7432;
x_0 = 0;
y_0 = 6;
v_x = 1;
v_y = 2;
g = 9.8;
x_p = [-l/2:0.001:l/2];
t = [0.001:0.001:10];
t_e = t;
o_b=0;
v=0;

for i = 1:length(t)
    x(i) = x_0 + v_x*t_e(i);
    y(i) = y_0 + v_y*t_e(i) - 0.5*g*t_e(i)*t_e(i);
    E(i) = 0.5*(v_y - g*t_e(i))^2 + 0.5*v_x^2 + g*y(i);
    
    if y(i) < 0
        
        if x_0*x(i) > 0
            break
        end
        
        v_y = -1*(v_y-g*t_e(i));
        y_0 = 0;
        x_0 = x(i);
         
        for j = i:length(t)
            t_e(j) = t(j) - t(i);
        end
        
    end
    
    if y(i)+5.6713*x(i)-7.7787 > 0
       
        v = sqrt((v_y - g*t_e(i))^2 + v_x^2);
        o_b = atan((v_y - g*t_e(i))/v_x);
        
        if v_x < 0
            o_b = o_b + pi;
        end
        
        o_b = 10*pi/9 - o_b;
        
        v_x = v*cos(o_b);
        v_y = v*sin(o_b);
        x_0 = x(i);
        y_0 = y(i);

        for k = i:length(t)
            t_e(k) = t(k) - t(i);
        end  
    end
    
    if y(i)-5.6713*x(i)-7.7787> 0
       
        v = sqrt((v_y - g*t_e(i))^2 + v_x^2);
        o_b = atan((v_y - g*t_e(i))/v_x);
        
        if v_x<0
            o_b = o_b + pi;
        end
        
        o_b = 8*pi/9 - o_b;
        
        v_x = v*cos(o_b);
        v_y = v*sin(o_b);
        x_0 = x(i);
        y_0 = y(i);

        for l= i:length(t)
            t_e(l) = t(l) - t(i);
        end  
    end
    
    if abs(x(i)) < 0.005
        if y(i) <= 0.1524
            break
        end
    end
end 

for m = 1:length(x_p)/2
    y_80(m) = 5.6713*(x_p(m)) + 7.7787;
    y_b1(m) = 0;
    plot(x_p(m), y_80(m), '.b')
    plot(x_p(m), y_b1(m), '.b')
end

for n = m:length(x_p)
    y_100(n) = -5.6713*(x_p(n)) + 7.7787;
    y_b2(n) = 0;
    plot(x_p(n), y_100(n), '.b')
    plot(x_p(n), y_b2(n), '.b')
    if x_p(n) < 0.154
        plot(0,x_p(n),'.b');
    end
end

plot(x, y, '.r');