function [] = build(ii,addr,leng,M_Ni,M_Cu,lat_p,dia,grading)
    rat=2*leng/dia;
    %addr='D:\Dropbox\Dropbox\codes_for_structures\';
    bath_wide = 0;
    surf_wide = 0;
    Z_dim = leng;
    r_base = leng/rat
    X_dim = (2*r_base); 
    Y_dim = (2*r_base);
    X_cent = X_dim/2;
    Y_cent = Y_dim/2;
    Ni_mass = 58.69;
    Cu_mass = 63.55;
    basis = [0.0 0.0 0.0
               0.0 0.5 0.5
               0.5 0.0 0.5
               0.5 0.5 0.0];
    basis = basis*(lat_p);      
    types  = ones(4,1);
    temp_basis = basis;
    atoms = [];
    n_x = round(X_dim/lat_p);
    n_y = round(Y_dim/lat_p);
    n_z = round(Z_dim/lat_p);
    atoms = [];
    for k = 1:n_z+2
        for j = 1:n_y+2
            for i = 1:n_x+2
                temp_basis = [basis(:,1)+(lat_p*(i-1)) basis(:,2)+(lat_p*(j-1)) basis(:,3)+(lat_p*(k-1))];
                for c = 1:4
                    if sqrt(((temp_basis(c,1) - (X_dim/2))^2) + ((temp_basis(c,2) - (Y_dim/2))^2))<=r_base
                        atoms = [atoms ; temp_basis(c,:)];
                    end
                end
            end
        end
    end
    n_atom = length(atoms);
    x_lo = min(atoms(:,1));
    y_lo = min(atoms(:,2));
    z_lo = min(atoms(:,3));
    x_hi = max(atoms(:,1));
    y_hi = max(atoms(:,2));
    z_hi = max(atoms(:,3));
    X_cent = X_dim/2;
    Y_cent = Y_dim/2;

    atoms = [(1:length(atoms))' 2*ones(length(atoms),1) atoms]

    res = lat_p/2;
        test_rad = 0 ;
    for i = 0 : round(r_base/res)-1
        r_dis_max = ((i+1)/round(r_base/res))*r_base;
        r_dis_min = ((i)/round(r_base/res))*r_base;
        temp_atoms = atoms(sqrt((atoms(:,3)-X_cent).^2 +(atoms(:,4)-Y_cent).^2 )>=r_dis_min,:)
        temp_atoms = temp_atoms(sqrt((temp_atoms(:,3)-X_cent).^2 +(temp_atoms(:,4)-Y_cent).^2 )<=r_dis_max,1);
        num_temp_atom = length(temp_atoms(:,1));
        b=i/round(r_base/res);
        if strcmp(grading,'P-FGM')
            x=b^ii;
        elseif strcmp(grading,'E-FGM')
            x=(1-(exp(-(b)^ii)));
        elseif strcmp(grading,'S-FGM')
            if i<= (round(r_base/res)-1)/2
                x=((1/2*(2*b)^ii));
                num_tbr = round((x/M_Ni)/(x/M_Ni+(1-x)/M_Cu)*num_temp_atom);
            else
                x=((1-1/2*(2*(1-b))^ii));
                num_tbr = round((x/M_Ni)/(x/M_Ni+(1-x)/M_Cu)*num_temp_atom);
            end
        else 
            str=['@(x)' grading];
            fh = str2func(str);
            x=fh(b);
        end
    
        
        num_tbr = round((x/M_Ni)/(x/M_Ni+(1-x)/M_Cu)*num_temp_atom);
        if num_tbr > num_temp_atom 
            num_tbr = num_temp_atom;
        end
        rand_ids = datasample(temp_atoms(:,1),num_tbr,'Replace',false)
        for j = 1:length(rand_ids)
            atoms(rand_ids(j),2)=1;
        end
    end
    
    
        
        mkdir([addr '\' char(string(ii)) '\']);
        filename = [addr '\' char(string(ii)) '\struct'];
        fid1 = fopen(filename,'wt');

        % ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        datafilecomment=['LAMMPS readable file ' char(string(ii))];
        fprintf(fid1,'%s\n',datafilecomment);
        fprintf(fid1,'%s\n','');
        fprintf(fid1,'\t\t%4i %s\n',n_atom,'atoms');
        fprintf(fid1,'\t\t%s\n','2 atom types');
        fprintf(fid1,'\t%12.8f %12.8f \t%s\n',x_lo-30,x_hi+30,'xlo xhi');
        fprintf(fid1,'\t%12.8f %12.8f \t%s\n',y_lo-30,y_hi+30,'ylo yhi');
        fprintf(fid1,'\t%12.8f %12.8f \t%s\n',z_lo,z_hi+(lat_p/2),'zlo zhi');
        fprintf(fid1,'%s\n','');
        fprintf(fid1,'%s\n','Masses');
        fprintf(fid1,'%s\n','');
        fprintf(fid1,'\t\t%s %12.8f\n','1',M_Ni);
        fprintf(fid1,'\t\t%s %12.8f\n','2',M_Cu);

        fprintf(fid1,'%s\n','');
        fprintf(fid1,'%s\n','Atoms');
        fprintf(fid1,'%s\n','');

        for i = 1:n_atom;    
            fprintf(fid1,'%i %i %12.8f %12.8f %12.8f\n',atoms(i,1:5));
        end
fclose('all');
end
