function pdf = log_normal_distribution(sigma,mu,x)
pdf = ((1./x).*(1/(sqrt(2*pi)*sigma)).*exp(-((log(x)-mu).^2)/(2*sigma*sigma)));
area = trapz(x,pdf);
pdf = pdf/area;
%     plot(x,pdf,'w','linewidth',1)
%     set(gcf,'color','k')
%     set(gca,'color','k','XColor','w','YColor','w','box','on','boxstyle','full')
%     xlabel('$$x$$','interpreter','latex','color','w','fontsize',14)
%     ylabel('$$pdf(x)$$','interpreter','latex','color','w','fontsize',14)
%     title({'','Log Normal Distribution',['$$\mu=$$',num2str(mu)],['$$\sigma=$$',num2str(sigma)]},'interpreter','latex','color','w','fontsize',14)
%     area(1) = 0;
%     for i=2:length(pdf)
%         area(i) = trapz(x(1:i),pdf(1:i));
%     end
%     hold on
%     plot(x,area,'r','linewidth',1)
%     dim = [0.75 0.45 0.3 0.3];
%     annotation('textbox',dim,'String','CDF','Interpreter','latex','Fontsize',14,'color','r');
end