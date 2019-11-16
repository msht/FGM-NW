function [] = myplot(Filename,leg,save)

%---------------------plot styling--------------------------------------------
legend('show');
DIMX = 6; DIMY =6;
set(gca,'Units', 'inches');
set(0, 'Units', 'inch');
BoxPos = [1, 1, DIMX, DIMY];
set(gca, 'Position', BoxPos);
monitorPos = get(0,'MonitorPositions');
% put the figure at the middle of the monitor
pos = [monitorPos(1, 3)/2-DIMX/2, monitorPos(1, 4)/2-DIMY/2];
outerpos = get(gca, 'OuterPosition');
if ~isempty(outerpos)
set(gca, 'OuterPosition',[0, 0, outerpos(3), outerpos(4)]);
set(gcf, 'Position', [100, 100, 700, 700]);
end
box on;
set(gca, 'FontName', 'Times New Roman','FontSize',25);
set(gca,'LineWidth',2);
set(gca,'XMinorTick','on','YMinorTick','on');
set(gca,'TickLength',[.02 .02]);
legend boxoff;
%ylim([0 13]);
%xlim([0.09 11]);
%xlim([0 14]);
%ytickformat('%.1f')
%xtickformat('%.1f')
if leg == 0
    legend 'off'
end
if save == 1
    %print(gcf, '-dmeta', '-opengl', sprintf('-r%d', 600), [Filename '.emf']);
    print(gcf, '-djpeg', '-opengl', sprintf('-r%d', 600), [Filename '.jpg']);
end
end

