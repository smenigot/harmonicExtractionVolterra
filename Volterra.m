% function [z_model] = Volterra(x,z,ordre,memoire,f0,fs)
% Hammerstein reconstruction
% Input : 
%   - input signal x
%   - output signal z
%   - order of the Hammerstein structure ordre
%   - memory of the Hammertein structure memoire
%   - frequency of the subharmonic f0
%   - sampling frequency fs
% Output :
%   - Model of the output signal z_model

function z_model = Volterra(x,z,ordre,memoire)

%% Build the input matrix
H = calculH(x,ordre,memoire);
%%
Y = z(memoire+1:length(z))';
R = H*H';
P = H*Y;

%%
[U,S,V] = svd(R);
D       = diag(S);
Ds      = sort(D,'descend');
index   = find(Ds>=0.01);
k       = index(end);
R_hat   = V(:,1:k)*pinv(S(1:k,1:k))*U(:,1:k)'; 
T       = R_hat*P;
%% Model of the output signal
z_model = zeros(size(z));
z_model(memoire+1:end) = H' * T;