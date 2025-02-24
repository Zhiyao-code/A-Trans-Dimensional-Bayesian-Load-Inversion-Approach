    function createSpokes(rMin,rMax,thetaMin,thetaMax,Ncircles,Nspokes)
        spokeMesh = linspace(thetaMin,thetaMax,Nspokes);
        circleMesh =linspace(rMin,rMax,Ncircles);
        contourD = circleMesh;     
        contourA=linspace(thetaMin,thetaMax,100);
        
        
        for kk = 1:(Nspokes-1)
            X = sin(spokeMesh(kk)).*contourD;
            Y = cos(spokeMesh(kk)).*contourD;
            plot(X,Y,'color',[0.5,0.5,0.5],'linewidth',0.75,...
                'handlevisibility','off');    
            hold on            
%             
%             text(1.05.*contourD(end).*sin(spokeMesh(kk)),...
%                     1.05.*contourD(end).*cos(spokeMesh(kk)),...
%                     [num2str(spokeMesh(kk)/2/pi*360,3),char(176)],...
%                     'horiz', 'center', 'vert', 'middle');
        end
        
        
        for kk = 1:Ncircles-1
            X = sin(contourA).*circleMesh(kk);
            Y = cos(contourA).*circleMesh(kk);
            plot(X,Y,'color',[0.5,0.5,0.5],'linewidth',0.75,...
                'handlevisibility','off');    
            hold on
                                
%             text(circleMesh(kk)*sind(30),...
%                 circleMesh(kk)*cosd(30),...
%                 num2str(circleMesh(kk)-200,3),'horiz', 'center', 'vert', 'middle');
        end
        
        axis equal
        
    end