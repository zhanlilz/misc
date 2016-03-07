%% Calculate mean of all normalized intensities and ranges from all three panels
% 
% Zhan Li, zhanli86@bu.edu
% Created, 20140114

% reflectance
refl1064 = [0.987, 0.5145, 0.3828, 0.0432];
refl1548 = [0.984, 0.4159, 0.2948, 0.0408];

% output file names
normdata1064file = '/projectnb/echidna/lidar/DWEL_Processing/DWEL_TestCal/cal-oz-uml-hf-20140425-0503/cal-oz-uml-hf-20140425-0503-refined-panel-return-summary/cal-oz-20140425-0503-panel-returns-fitting/cal_oz_20140425_0503_panel_returns_refined_norm_mean_1064_fitting.txt';
normdata1548file = '/projectnb/echidna/lidar/DWEL_Processing/DWEL_TestCal/cal-oz-uml-hf-20140425-0503/cal-oz-uml-hf-20140425-0503-refined-panel-return-summary/cal-oz-20140425-0503-panel-returns-fitting/cal_oz_20140425_0503_panel_returns_refined_norm_mean_1548_fitting.txt';

validationdir = '/projectnb/echidna/lidar/DWEL_Processing/DWEL_TestCal/cal-oz-uml-hf-20140425-0503/cal-oz-uml-hf-20140425-0503-refined-panel-return-summary/cal-oz-20140425-0503-panel-returns-validation/';

valratio = 0.2;

% all unsaturated data files
refineddatadir = '/projectnb/echidna/lidar/DWEL_Processing/DWEL_TestCal/cal-oz-uml-hf-20140425-0503/cal-oz-uml-hf-20140425-0503-refined-panel-return-summary';

refined1064files = { ...
'cal_oz_20140425_0_5_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_10_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_11_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_12_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_13_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_14_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_15_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_1_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_1_5_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_20_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_25_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_2_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_2_5_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_30_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_35_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_3_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_3_5_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_40_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_4_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_4_5_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_50_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_5_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_5_5_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_60_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_6_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_6_5_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_70_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_7_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_7_5_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_8_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_8_5_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_9_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_9_5_1064_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
};

refined1548files = { ...
'cal_oz_20140425_0_5_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_10_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_11_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_12_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_13_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_14_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_15_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_1_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_1_5_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_20_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_25_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_2_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_2_5_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_30_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_35_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_3_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_3_5_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_40_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_4_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_4_5_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_50_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_5_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_5_5_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_60_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_6_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_6_5_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_70_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_7_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_7_5_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_8_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_8_5_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_9_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
'cal_oz_20140425_9_5_1548_cube_bsfix_pxc_update_ptcl_points_panel_returns_refined.txt' ...
};

% scale factor
scale1064file = '/projectnb/echidna/lidar/DWEL_Processing/DWEL_TestCal/cal-oz-uml-hf-20140425-0503/cal-oz-uml-hf-20140425-0503-refined-panel-return-summary/cal_oz_20140425_0503_laser_power_scale_factors_1064.txt';
scale1548file = '/projectnb/echidna/lidar/DWEL_Processing/DWEL_TestCal/cal-oz-uml-hf-20140425-0503/cal-oz-uml-hf-20140425-0503-refined-panel-return-summary/cal_oz_20140425_0503_laser_power_scale_factors_1548.txt';

prange = [ ...
0.5 ...
10 ...
11 ...
12 ...
13 ...
14 ...
15 ...
1 ...
1.5 ...
20 ...
25 ...
2 ...
2.5 ...
30 ...
35 ...
3 ...
3.5 ...
40 ...
4 ...
4.5 ...
50 ...
5 ...
5.5 ...
60 ...
6 ...
6.5 ...
70 ...
7 ...
7.5 ...
8 ...
8.5 ...
9 ...
9.5 ...
];
prange = prange';

numpanels = 4;

% read scale factors
fid = fopen(scale1064file, 'r');
data = textscan(fid, repmat('%f', 1, numpanels+1), 'HeaderLines', 1, 'Delimiter', ',');
fclose(fid);
scale1064 = cell2mat(data);

fid = fopen(scale1548file, 'r');
data = textscan(fid, repmat('%f', 1, numpanels+1), 'HeaderLines', 1, 'Delimiter', ',');
fclose(fid);
scale1548 = cell2mat(data);

% sample data points from all unsaturated data
normdata1064 = nan(length(refined1064files), 5);
normdata1548 = nan(length(refined1064files), 5);
for f=1:length(refined1064files)
    if exist(fullfile(refineddatadir, refined1064files{f}))
        fid = fopen(fullfile(refineddatadir, refined1064files{f}), 'r');
        data = textscan(fid, repmat('%f', 1, 12), 'HeaderLines', 1, 'Delimiter', ',');
        fclose(fid);
        data = cell2mat(data);
        
        % get the scale factor
        tmpind = scale1064(:, 1) == prange(f);
        if sum(tmpind)~=1
            fprintf, 'nominal range values are wrong in either prange or scale factor file!\n'
            return
        end
        tmp = scale1064(tmpind, 2:numpanels+1);
        scalefactor = zeros(size(data(:, 12)));
        for p =1:numpanels
            scalefactor(data(:, 12)==p) = tmp(p);
        end
        data(:, 2) = data(:, 2).*scalefactor;

        tmpflag = data(:, 3)==1 & data(:, 9)==0 & data(:, 12)<=numpanels;
        data = data(tmpflag, :);
        ndata = size(data, 1);
        nvals = fix(ndata*valratio);
        sampleind = randsample(ndata, nvals);
        % write select samples for validation to a file
        tmpstr = refined1064files{f};
        filename = fullfile(validationdir, [tmpstr(1:end-4), '_validation.txt']);
        % if old validation file exists, delete it first
        if exist(filename, 'file')
            fprintf('Old validation file deleted: %s\n', filename)
            delete(filename)
        end
        if sum(tmpflag)>=1
            fid = fopen(filename, 'w');
            fprintf(fid, 'shot_num,d_out,number_of_returns,range,I,FWHM,sample,line,sat_flag,tzero,tzero_int,panel_ind\n');
            fprintf(fid, '%d,%.3f,%d,%.3f,%.3f,%.3f,%d,%d,%d,%.3f,%.3f,%d\n', (data(sampleind, :))');
            fclose(fid);
            % remaining are data for calibration fitting, get the mean
            data(sampleind, :)=[];
            data = [data(:, 4), data(:, 2)./(refl1064(data(:, 12)))'];
            normdata1064(f, :) = [mean(data(:, 1)), std(data(:, 1)), mean(data(:, 2)), std(data(:, 2)), f];
        end
    end

    if exist(fullfile(refineddatadir, refined1548files{f}))
        fid = fopen(fullfile(refineddatadir, refined1548files{f}), 'r');
        data = textscan(fid, repmat('%f', 1, 12), 'HeaderLines', 1, 'Delimiter', ',');
        fclose(fid);
        data = cell2mat(data);

        % get the scale factor
        tmpind = scale1548(:, 1) == prange(f);
        if sum(tmpind)~=1
            fprintf, 'nominal range values are wrong in either prange or scale factor file!\n'
            return
        end
        tmp = scale1548(tmpind, 2:numpanels+1);
        scalefactor = zeros(size(data(:, 12)));
        for p =1:numpanels
            scalefactor(data(:, 12)==p) = tmp(p);
        end
        data(:, 2) = data(:, 2).*scalefactor;

        tmpflag = data(:, 3)==1 & data(:, 9)==0 & data(:, 12)<=numpanels;
        data = data(tmpflag, :);
        ndata = size(data, 1);
        nvals = fix(ndata*valratio);
        sampleind = randsample(ndata, nvals);
        % write select samples for validation to a file
        tmpstr = refined1548files{f};
        filename = fullfile(validationdir, [tmpstr(1:end-4), '_validation.txt']);
        % if old validation file exists, delete it first
        if exist(filename, 'file')
            fprintf('Old validation file deleted: %s\n', filename)
            delete(filename)
        end
        if sum(tmpflag)>=1
            fid = fopen(filename, 'w');
            fprintf(fid, 'shot_num,d_out,number_of_returns,range,I,FWHM,sample,line,sat_flag,tzero,tzero_int,panel_ind\n');
            fprintf(fid, '%d,%.3f,%d,%.3f,%.3f,%.3f,%d,%d,%d,%.3f,%.3f,%d\n', (data(sampleind, :))');
            fclose(fid);
            % remaining are data for calibration fitting, get the mean
            data(sampleind, :)=[];
            refls = zeros(size(data(:, 12)));
            for p=1:numpanels
                refls(data(:,12)==p) = refl1548(p);
            end
            data = [data(:, 4), data(:, 2)./refls];
            normdata1548(f, :) = [mean(data(:, 1)), std(data(:, 1)), mean(data(:, 2)), std(data(:, 2)), f];
        end
    end
end

tmpflag = ~isnan(normdata1064(:,1));
normdata1064 = normdata1064(tmpflag, :);
tmpflag = ~isnan(normdata1548(:,1));
normdata1548 = normdata1548(tmpflag, :);

% write mean normalized data to text files
fid = fopen(normdata1064file, 'w');
fprintf(fid, 'range_mean,range_sd,norm_intensity_mean,norm_intensity_sd,panel_rg_id\n');
fprintf(fid, [repmat('%.3f,',1,3), '%.3f,%d\n'], normdata1064');
fclose(fid);
fid = fopen(normdata1548file, 'w');
fprintf(fid, 'range_mean,range_sd,norm_intensity_mean,norm_intensity_sd,panel_rg_id\n');
fprintf(fid, [repmat('%.3f,',1,3), '%.3f,%d\n'], normdata1548');
fclose(fid);