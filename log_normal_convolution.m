function log_normal_convolution(x,y,sigma,mu,N)
figure()
xq = linspace(min(x),max(x),1000);
yq = interp1(x,y,xq);
area = trapz(xq,yq);
yq = yq/area;
plot(xq,yq,'r','linewidth',5)
hold on

f1 = log_normal_distribution(sigma,mu,xq);
pdf_conv(1,:) = f1;
plot(xq,pdf_conv(1,:),'g')
for i = 2:N
    temp = conv(pdf_conv(i-1,:),f1);
    temp = temp(1:length(f1));
    area = trapz(xq,temp);
    temp = temp/area;
    pdf_conv(i,:) = temp;
    plot(xq,pdf_conv(i,:),'g')
end
fgfit=@(b) sum(abs(b*pdf_conv-yq));

lb=zeros(1,size(pdf_conv,1));
ub=ones(1,size(pdf_conv,1));
beta0=ub/2;
A = ub;
Aeq = ub;
b = 1;
beq = 1;
beta = fmincon(fgfit,beta0,A,b,Aeq,beq,lb,ub);

conv_fun = @(b) b*pdf_conv;
y_fit = conv_fun(beta);
plot(xq,y_fit,'b','linewidth',2)

diff = y_fit-yq;
plot(xq,diff,'k')

xlim([0 max(x)])
dim = [0.5 0.55 0.3 0.3];
str = num2str(beta');
annotation('textbox',dim,'String',str,'FitBoxToText','on','Interpreter','latex','Fontsize',16);
ax=gca;
ax.TickDir = 'out';
ax.TickLength = [0.02 0.035];
ax.FontSize =18;
ax.FontName='TimesNewRoman';
ax.YLabel.String = 'PDF';
ax.XLabel.String = 'Localizations';
axe=gcf;
axe.Color='white';
title('Sum of convolution of log normal distribution functions','interpreter','latex')
end