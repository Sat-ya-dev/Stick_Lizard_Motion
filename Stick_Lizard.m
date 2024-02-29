clc;
clf;
clear all;

pt=[2;2];
% Angles
theta = zeros(8,7);
theta(1,:)= [0.5,-0.5,0.5,0.78,-2.35,-1.3,1.8];
theta(2,:)= [0.25,-0.25,0.25,1,-2,-1.3,1.8];
theta(3,:)= [0,0,0,1.57,-1.57,1.57,-1.57];
theta(4,:)= [-0.25,0.25,-0.25,-1,2,1.3,-1.8];
theta(5,:)= [-0.5,0.5,-0.5,-0.78,2.3,1.3,-1.8];
theta(6,:)= [-0.25,0.25,-0.25,-1,2,1.3,-1.8];
theta(7,:)= [0,0,0,1.57,-1.57,1.57,-1.57];
theta(8,:)= [0.25,-0.25,0.25,1,-2,-1.3,1.8];

% Press q to quit
count=1;
while true
    clf;
    plot_p(pt,theta(count,1),theta(count,2),theta(count,3),theta(count,4),theta(count,5),theta(count,6),theta(count,7));
    charc = getChar();
    if charc == 'q'
        clf;
        break;
    else
        switch charc
            case {30,'w'} % ascii of up arrow key is 30
                pt=pt+[0;1];
            case {31,'s'} % ascii of down arrow is 31 
                pt=pt-[0;1]; 
            case {29,'d'} % ascii of right arrow key is 29
                pt=pt+[1;0];
            case {28,'a'} % ascii of left arrow key is 28
                pt=pt-[1;0]; 
        end
        count=count+1;
    end
    if count == 9
        count=1;
    end
end

% Plot function
function plot_p(pt,th1,th2,th3,th4,th5,th6,th7)
    %Relative position of point wrt pt
    p2=rotation1(th1)*[1;0] + pt;
    
    p3_1=rotation1(th2)*[1;0] + [1; 0];
    p3=rotation1(th1)*p3_1 + pt;

    p4_2= rotation1(th3)*[1; 0] + [1; 0];
    p4_1=rotation1(th2)*p4_2+[1; 0];
    p4 = rotation1(th1)*p4_1 + pt;

    p5=rotation1(th1)*rotation1(th4)*[0.5;0]+p2;
    p6=rotation1(th1)*rotation1(th5)*[0.5; 0]+p2;

    p7=rotation1(th1)*rotation1(th2)*rotation1(th6)*[0.5;0]+p3;
    p8=rotation1(th1)*rotation1(th2)*rotation1(th7)*[0.5; 0]+p3;

    patch(X=[pt(1,1) p2(1,1)], Y = [pt(2,1) p2(2,1)]); %head
    patch(X=[p2(1,1) p3(1,1)], Y = [p2(2,1) p3(2,1)]); %body
    patch(X=[p3(1,1) p4(1,1)], Y = [p3(2,1) p4(2,1)]); %tail
    patch(X=[p2(1,1) p5(1,1)], Y = [p2(2,1) p5(2,1)]); %hands
    patch(X=[p2(1,1) p6(1,1)], Y = [p2(2,1) p6(2,1)]);
    patch(X=[p3(1,1) p7(1,1)], Y = [p3(2,1) p7(2,1)]); %legs
    patch(X=[p3(1,1) p8(1,1)], Y = [p3(2,1) p8(2,1)]);
    xlim([-15 15]); ylim([-15 15]);
    % axis equal;
end

% Rotation matrix
function R1 = rotation1(theta)
    R1 = [cos(theta) -sin(theta); sin(theta) cos(theta)];
end

% For getting character of keyboard
function charc = getChar()
    w=waitforbuttonpress;
    if w == 1
       charc=get(gcf,'CurrentCharacter');
    else
        charc = '';
    end
end