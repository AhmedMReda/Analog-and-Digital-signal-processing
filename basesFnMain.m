function [phi]= basesFnMain(Input,Ts)
    close all

    Asize=size(Input);
    M=Asize(2); %number of signals
    n=Asize(1); %time divisions
    Tb=Ts/n; %Tb = bit time, Ts = signal time
    
    for i=1:M
        Si=Input(:,i);%extract the first column(signal)
        gi=Si;
        for j=1:i-1
           sij=Si'*phi(:,j)*Tb; %calculate sij
           gi=gi-sij*phi(:,j); %calculate gi
        end
        sqrt_Egi= norm(gi)*sqrt(Tb); %norm = the sqrt of the energy
        phi(:,i)=gi/sqrt_Egi; %calculate phi
        %plot s
        figure(1)
        subplot(M,1,i);
        plotter(Si,Ts);
        %plot phi
        figure(2)
        subplot(M,1,i);
        plotter(phi(:,i),Ts)
    end
end 

%function gets matrices and plot them
function plotter(y,Ts)
    n=length(y);
    step=1/(1000*n);
    t=0:(step*Ts):(Ts-step);
    T=length(t);
    x=ones(1,1000*n);
    for j=1:n
           x( (j-1)*(T/n) +1 : j*(T/n)) = y(j,1);
    end
    plot(t,x,'LineWidth',2)
end
