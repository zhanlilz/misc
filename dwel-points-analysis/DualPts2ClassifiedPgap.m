% read two point clouds of apparent reflectances and FWHM at the two
% wavelengths to calculate pgap for leaves and branches separately.
clear;

% ******************************************************************************
% Arguments for inputs
nirptsfile = '/projectnb/echidna/lidar/DWEL_Processing/HF2014/Hardwood20140919/HFHD_20140919_C/HFHD_20140919_C_1064_cube_bsfix_pxc_update_atp2_sdfac2_sievefac10_ptcl_points.txt';
swirptsfile = '/projectnb/echidna/lidar/DWEL_Processing/HF2014/Hardwood20140919/HFHD_20140919_C/HFHD_20140919_C_1548_cube_bsfix_pxc_update_atp2_sdfac2_sievefac10_ptcl_points.txt';

scanres = 2.0e-3/pi*180; % deg
hbinsize = 0.5; % meter
zenbinsize = 5; % degrees
minzen = 5; % deg
maxzen = 70; % deg
maxh = 50;
ndi_thresh = 0.45;

pulse_fwhm_nir = 3.6469;
pulse_fwhm_swir = 3.6469;

leaf_refl = [0.43, 0.29];
wood_refl = [0.65, 0.54];
% Arguments for outputs
ptsndifile = '/projectnb/echidna/lidar/DWEL_Processing/HF2014/Hardwood20140919/HFHD_20140919_C/HFHD_20140919_C_cube_bsfix_pxc_update_atp2_sdfac2_sievefac10_ptcl_points_ndi.txt';
% ******************************************************************************

% read point cloud data
fid = fopen(nirptsfile, 'r');
nirpts = textscan(fid, repmat('%f', 1, 17), 'HeaderLines', 3, 'Delimiter', ',');
fclose(fid);
nirpts = cell2mat(nirpts);
fid = fopen(swirptsfile, 'r');
swirpts = textscan(fid, repmat('%f', 1, 17), 'HeaderLines', 3, 'Delimiter', ',');
fclose(fid);
swirpts = cell2mat(swirpts);

% suppress all negative intensity to zero
tmplogic = nirpts(:, 4)<0;
nirpts(tmplogic, 4)=0;
tmplogic = swirpts(:, 4)<0;
swirpts(tmplogic, 4)=0;
% remove all zero locations
tmplogic = nirpts(:, 1)==0 & nirpts(:,2)==0 & nirpts(:,3)==0 & nirpts(:,4)==0;
nirptsvalidind = find(~tmplogic);
tmplogic = swirpts(:,1)==0 & swirpts(:,2)==0 & swirpts(:,3)==0 & swirpts(:,4)==0;
swirptsvalidind = find(~tmplogic);
% find the common points between 1064 and 1548 by checking their return
% numbers (1st or 2nd or ... return) and their angular positions. 
% If the three fields are the same, we think there is common point pair.
% !!! This might NOT BE TRUE, e.g. when two peaks are extracted from the
% 1548 nm while only one peak from the 1064 nm. !!!
[~, inir, iswir] = intersect([nirpts(nirptsvalidind, 5:6), nirpts(nirptsvalidind,13:14)], [swirpts(swirptsvalidind, 5:6), swirpts(swirptsvalidind,13:14)], 'rows');
% NDI of each common point
nirptscmind = nirptsvalidind(inir);
swirptscmind = swirptsvalidind(iswir);
pts_ndi = (nirpts(nirptscmind, 4)-swirpts(swirptscmind, 4))./(nirpts(nirptscmind, 4)+swirpts(swirptscmind, 4));
pts_mean = (nirpts(nirptscmind, 1:3)+swirpts(swirptscmind, 1:3))/2;

% write NDI points to an ascii file
fid = fopen(ptsndifile, 'w');
infid = fopen(nirptsfile, 'r');
linestr = fgetl(infid);
fprintf(fid, '%s; NDI\n', linestr);
linestr = fgetl(infid);
fprintf(fid, '%s\n', linestr);
fclose(infid);
fprintf(fid, ['X,Y,Z,NDI,d_I_nir,d_I_swir,Return_Number,Number_of_Returns,' ...
              'range_nir_minus_swir,theta,phi,Sample,Line,I_nir,FWHM_nir,I_swir,FWHM_swir\n']);
cmpts = [pts_mean, pts_ndi, ...
                    nirpts(nirptscmind,4), swirpts(swirptscmind, 4), ...
                    nirpts(nirptscmind,5:6), nirpts(nirptscmind,9)- ...
                    swirpts(swirptscmind,9), (nirpts(nirptscmind, 10:11)+ ...
                                              swirpts(swirptscmind, 10:11))/2, ...
                    nirpts(nirptscmind, 13:14), nirpts(nirptscmind, 16:17), ...
                    swirpts(swirptscmind, 16:17)];
fprintf(fid, [repmat('%.3f,',1,6), repmat('%d,',1,2), repmat('%.3f,',1,3), ...
              repmat('%d,',1,2),repmat('%d,',1,4),'\b\n'], cmpts');
fclose(fid);

% calculate Pgap from apparent reflectance for each point/scattering
% event. Pgap is the gap probability from the instrument to the point. 
sampleind = unique(nirpts(nirptscmind, 13));
lineind = unique(nirpts(nirptscmind, 14));
for l=1:length(lineind)
    for 
end

heights = 0:hbinsize:maxh;
nzenithbins = fix((maxzen-minzen)/zenbinsize);
midzeniths = (0:nzenithbins-1)*zenbinsize + zenbinsize/2;
pgapz_total_nir = ones(nzenithbins, length(heights));
pgapz_leaf_nir = ones(nzenithbins, length(heights));
pgapz_branch_nir = ones(nzenithbins, length(heights));
pgapz_total_swir = ones(nzenithbins, length(heights));
pgapz_leaf_swir = ones(nzenithbins, length(heights));
pgapz_branch_swir = ones(nzenithbins, length(heights));

for zen=1:1:nzenithbins
    zenind = data(:,9) > midzeniths(zen)-zenbinsize/2.0 & data(:,9) < midzeniths(zen)+zenbinsize/2.0;
    if sum(zenind) > 0
        pointdata = data(zenind, :);
        w = 1.0./pointdata(:,8);
        leafind = pointdata(:,4)>ndi_thresh;
        for hi =1:1:length(heights)
            hits_leaf = sum(w(leafind & pointdata(:,3)<= heights(hi)));
            pgapz_leaf(zen, hi) = 1.0 - hits_leaf/npulses;
            hits_branch = sum(w(~leafind & pointdata(:,3)<=heights(hi)));
            pgapz_branch(zen, hi) = 1.0 - hits_branch/npulses;
        end
    end
end

fid = fopen('midzeniths.txt', 'w');
fprintf(fid, '%.3f\n', midzeniths);
fclose(fid);
fid = fopen('heights.txt', 'w');
fprintf(fid, '%.3f\n', heights);
fclose(fid);
fid = fopen('pgapz_leaf.txt', 'w');
fprintf(fid, [repmat('%.3f,', 1, length(heights)-1), '%.3f\n'], pgapz_leaf');
fclose(fid);
fid = fopen('pgapz_branch.txt', 'w');
fprintf(fid, [repmat('%.3f,', 1, length(heights)-1), '%.3f\n'], pgapz_branch');
fclose(fid);

% % plot pgap
% figure('Name', 'Pgap, leaves');
% plot(pgapz_leaf(1,:), heights, '-r');
% hold on;
% for i=2:nzenithbins
%     plot(pgapz_leaf(i,:), heights);
% end
% figure('Name', 'Pgap, branches');
% plot(pgapz_branch(1,:), heights, '-r');
% hold on;
% for i=2:nzenithbins
%     plot(pgapz_branch(i,:), heights);
% end

% calculate area index and profile
% David Jupp's linear model
%[LAIprofile, MLA, LAVD] = LM_pgap2profile(midzeniths,heights,pgapz_leaf);
%[BAIprofile, MBA, BAVD] = LM_pgap2profile(midzeniths,heights,pgapz_branch);
