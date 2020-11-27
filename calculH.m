% function H = calculH(x,ordre,memoire)
% Build the input matrix
% Input
%	x the input signal
% 	order of the decomposition
% 	memory of the decomposition
% Output
% 	H input matrix

function H = calculH(x,ordre,memoire)


%% Build the matrix
for t = memoire+1:length(x)
    %% Out
    % linear parameter
    clear YmMat YmCell
    YmMat = x(t-1:-1:t-memoire)'; % signal for an order
    for kM = 1:memoire
        YmCell{kM} = YmMat(kM:end);
    end

    for kO = 2:ordre
        for kM = 1:memoire 
            YmCell{kM} = YmCell{kM} .* x(t-kM); % computation of a signal for the order kO
        end
        for kM = 1:memoire
            YmCell{kM} = cell2mat(YmCell(kM:end)');
        end
        YmMat = cat(1,YmMat,YmCell{1});
    end
    H(:,t-memoire) = YmMat;
end
