function fit_log_normal(x,y)
figure()
xq = linspace(min(x),max(x),1000);
yq = interp1(x,y,xq);
area = trapz(xq,yq);
yq = yq/area;
plot(xq,yq,'r','linewidth',5)
hold on

fgfit=@(b) log_normal_distribution(b(1),b(2),xq)-yq;
lb=[0,0];
ub=[1000,max(xq)];
beta0=[100,mean(xq)];
beta=lsqnonlin(fgfit,beta0,lb,ub);
y_fit = fgfit(beta)+yq;
plot(xq,y_fit,'color','b','linewidth',2)

dim = [0.5 0.55 0.3 0.3];
str = {['$$\mu = $$',num2str(beta(2))],['$$\sigma = $$',num2str(beta(1))]};
annotation('textbox',dim,'String',str,'FitBoxToText','on','Interpreter','latex','Fontsize',16);
xlim([0 max(xq)])
ax=gca;
ax.TickDir = 'out';
ax.TickLength = [0.02 0.035];
ax.FontSize =18;
ax.FontName='TimesNewRoman';
ax.YLabel.String = 'PDF';
ax.XLabel.String = 'Localizations';
axe=gcf;
axe.Color='white';
title('Log normal distribution function','interpreter','latex')
end