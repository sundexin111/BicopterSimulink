function q=Q_normalize(Q)
    quatMag = Q_length(Q);
    if (quatMag~=0) 
        quatMagInv = 1.0/quatMag;
        Q(1) = Q(1) * quatMagInv;
        Q(2) = Q(2) * quatMagInv;
        Q(3) = Q(3) * quatMagInv;
        Q(4) = Q(4) * quatMagInv;
    end
    q=[Q(1),Q(2),Q(3),Q(4)];
end

