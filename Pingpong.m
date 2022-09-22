format long;

hold on;
x_0 = -1.3716;
y_0 = 0.91875;
v_x = 2.7432;
v_y = 2.45;
g = 9.8;
t = [0.001:0.001:2*1000];
t_e = t;
t_f = t;

for i = 1:length(t)
    x(i) = x_0 + v_x*t_f(i);
    y(i) = y_0 + v_y*t_e(i) - 0.5*g*t_e(i)*t_e(i);
    E(i) = 0.5*(v_y - g*t_e(i))^2 + 0.5*v_x^2 + g*y(i);
    
    if y(i) < 0
        v_y = -1*(v_y-g*t_e(i));
        y_0 = 0;
         
        for j = i:length(t)
            t_e(j) = t(j) - t(i);
        end
        
    end
    
    if rem(i, 1000) == 0
        v_x = -1*v_x;
        x_0 = -1*x_0;

        for k = i:length(t)
            t_f(k) = t(k) - t(i);
        end  
    end
end 

plot(x, y, '.b');