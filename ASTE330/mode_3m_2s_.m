function [norm_freqs,norm_amplitudes] = mode_3m_2s_(m1,m2,m3,k1,k2)
K = [k1, -k1, 0; -k1, (k1+k2), -k2; 0, -k2, k2];
M = [m1, 0, 0; 0, m2, 0; 0, 0, m3];
S = inv(M)*K ;

[a,F] = eig(S);

norm_freqs = [sqrt(F(1,1)), sqrt(F(2,2)), sqrt(F(3,3))] / (2 * pi)
norm_amplitudes = a
end
