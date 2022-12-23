function [] = savePlotPdf(figName)
    figPath = '../../Notes/figures';
%     figName = 'simulate';
    set(gcf,'Units','Inches');
    pos = get(gcf,'Position');
    set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    saveas(gcf,sprintf('%s\\%s.pdf',figPath,figName));
end