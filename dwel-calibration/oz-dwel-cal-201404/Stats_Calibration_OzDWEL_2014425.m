% Calculate statistics of waveforms from calibration measurements
% with Oz DWEL on April 25, 2014. 
% 
% One file contains returns from all four panels of different reflectances. 
% We can tell the returns from different panels by checking out the waveform
% maximum intensities and their locations of all waveforms in file from a
% plot created here.  
% The sequence of the panels in a file is: 
% 0. panel name, 1064 refl, 1548 refl
% 1. Lambertian panel, 0.99, 0.99
% 2. Grey panel 1, 0.436, 0.349
% 3. Grey panel 2, 0.320, 0.245
% 4. Black panel, 0.041, 0.041
% 
% In the plot of waveform maximum intensities and locations from one file,
% you will see a sequence like this: 
% 
% 0. low wf max, very short range: dummy returns by blocking lasers at the
% scanning mirror
% 
% 1. high wf max, correct range (if not, returns are not high enough to pick
% out the correct range from wf maximum): lambertian panel
% 
% 0. low wf max, very short range: dummy returns by blocking lasers at the
% scanning mirror
% 
% 2. high wf max, correct range (if not, returns are not high enough to pick
% out the correct range from wf maximum): grey panel 1
% 
% 0. low wf max, very short range: dummy returns by blocking lasers at the
% scanning mirror
% 
% 3. high wf max, correct range (if not, returns are not high enough to pick
% out the correct range from wf maximum): grey panel 2
% 
% 0. low wf max, very short range: dummy returns by blocking lasers at the
% scanning mirror
% 
% 4. high wf max, correct range (if not, returns are not high enough to pick
% out the correct range from wf maximum): black panel
% 
% 0. remaining: all dummy returns

% the parent folder to all the calibration HDF5 folders.
dirname = '/projectnb/echidna/lidar/Data_DWEL_TestCal/Calibration_OzDWEL_20140425-0503';

filelist = { ...
'0_5/waveform_2014-04-25-17-44.hdf5'; ...
'1/waveform_2014-04-25-17-41.hdf5'; ...
'1_5/waveform_2014-04-25-17-39.hdf5'; ...
'2_5/waveform_2014-04-25-17-34.hdf5'; ...
'3/waveform_2014-04-25-17-32.hdf5'; ...
'3_5/waveform_2014-04-25-17-30.hdf5'; ...
'4/waveform_2014-04-25-17-27.hdf5'; ...
'4_5/waveform_2014-04-25-17-25.hdf5'; ...
'5/waveform_2014-04-25-17-20.hdf5'; ...
'5_5/waveform_2014-04-25-17-17.hdf5'; ...
'6/waveform_2014-04-25-17-15.hdf5'; ...
'6_5/waveform_2014-04-25-17-11.hdf5'; ...
'7/waveform_2014-04-25-17-08.hdf5'; ...
'7_5/waveform_2014-04-25-17-05.hdf5'; ...
'8/waveform_2014-04-25-16-58.hdf5'; ...
'8_5/waveform_2014-04-25-16-56.hdf5'; ...
'9/waveform_2014-04-25-16-53.hdf5'; ...
'9_5/waveform_2014-04-25-16-51.hdf5'; ...
'10/waveform_2014-04-25-16-48.hdf5'; ...
'11/waveform_2014-04-25-16-45.hdf5'; ...
'12/waveform_2014-04-25-16-42.hdf5'; ...
'13/waveform_2014-04-25-16-39.hdf5'; ...
'14/waveform_2014-04-25-16-33.hdf5'; ...
'15/waveform_2014-04-25-16-31.hdf5'; ...
'2/waveform_2014-04-25-17-37.hdf5'; ...
'20/waveform_2014-04-25-16-27.hdf5'; ...
'25/waveform_2014-04-25-16-24.hdf5'; ...
'30/waveform_2014-04-25-16-20.hdf5'; ...
'35/waveform_2014-04-25-16-16.hdf5'; ...
'40/waveform_2014-04-25-16-13.hdf5'; ...
'50/waveform_2014-04-25-16-09.hdf5'; ...
'60/waveform_2014-04-25-16-06.hdf5'; ...
'70/waveform_2014-04-25-16-01.hdf5'; ...
};

% INPUT INPUT INPUT INPUT INPUT INPUT INPUT INPUT
% choose the waveform file you want to analyze
fileind = 28;
% INPUT INPUT INPUT INPUT INPUT INPUT INPUT INPUT

% read the whole waveform data
inputfile = fullfile(dirname, filelist{fileind}); fprintf('%s\n', inputfile);
wf1064 = h5read(inputfile, '/1064 Waveform Data');
wf1548 = h5read(inputfile, '/1548 Waveform Data');
% get the waveform maximum
[wf1064_max, wf1064_max_pos] = max(wf1064, [], 1);
[wf1548_max, wf1548_max_pos] = max(wf1548, [], 1);
wf1064_max = double(wf1064_max);
wf1064_max_pos = double(wf1064_max_pos);
wf1548_max = double(wf1548_max);
wf1548_max_pos = double(wf1548_max_pos);
% plot waveform maximums and their location to identify slices of
% useful waveforms from panels of different reflectances
figure('Name', '1064 waveform'); 
subplot(2, 1, 1);
plot(wf1064_max, '.'); title(['1064 wf max: ', filelist{fileind}]);
subplot(2, 1, 2);
plot(wf1064_max_pos, '.'); title('location of 1064 waveform maximum intensity');
figure('Name', '1548 waveform'); 
subplot(2, 1, 1);
plot(wf1548_max, '.'); title(['1548 wf max: ', filelist{fileind}]);
subplot(2, 1, 2);
plot(wf1548_max_pos, '.'); title(['location of 1548 waveform maximum ' ...
                    'intensity']);

% INPUT INPUT INPUT INPUT INPUT INPUT INPUT INPUT
% update the vector "panelslice" with the start and ending indice of the
% panels of our interest
panelslice = [ ...
12200, 22010; ... % lambertian panel
34750, 44970; ... % grey panel 1
66520, 77510; ... % grey panel 2
99270, 110800; ... % black panel
];
% INPUT INPUT INPUT INPUT INPUT INPUT INPUT INPUT

% calculate some stats
% 1064 wf max intensity
minwfmax1064 = [ min(wf1064_max(panelslice(1,1):panelslice(1,2))), ...
                 min(wf1064_max(panelslice(2,1):panelslice(2,2))), ...
                 min(wf1064_max(panelslice(3,1):panelslice(3,2))), ...
                 min(wf1064_max(panelslice(4,1):panelslice(4,2)))];
maxwfmax1064 = [ max(wf1064_max(panelslice(1,1):panelslice(1,2))), ...
                 max(wf1064_max(panelslice(2,1):panelslice(2,2))), ...
                 max(wf1064_max(panelslice(3,1):panelslice(3,2))), ...
                 max(wf1064_max(panelslice(4,1):panelslice(4,2)))];
meanwfmax1064 = [ mean(wf1064_max(panelslice(1,1):panelslice(1,2))), ...
                  mean(wf1064_max(panelslice(2,1):panelslice(2,2))), ...
                  mean(wf1064_max(panelslice(3,1):panelslice(3,2))), ...
                  mean(wf1064_max(panelslice(4,1):panelslice(4,2)))];
medianwfmax1064 = [ median(wf1064_max(panelslice(1,1):panelslice(1,2))), ...
                    median(wf1064_max(panelslice(2,1):panelslice(2,2))), ...
                    median(wf1064_max(panelslice(3,1):panelslice(3,2))), ...
                    median(wf1064_max(panelslice(4,1):panelslice(4,2)))];
stdwfmax1064 = [ std(wf1064_max(panelslice(1,1):panelslice(1,2))), ...
                 std(wf1064_max(panelslice(2,1):panelslice(2,2))), ...
                 std(wf1064_max(panelslice(3,1):panelslice(3,2))), ...
                 std(wf1064_max(panelslice(4,1):panelslice(4,2)))];
% 1064 wf max location, before interpolation
minwfmaxpos1064 = [ min(wf1064_max_pos(panelslice(1,1):panelslice(1,2))), ...
                 min(wf1064_max_pos(panelslice(2,1):panelslice(2,2))), ...
                 min(wf1064_max_pos(panelslice(3,1):panelslice(3,2))), ...
                 min(wf1064_max_pos(panelslice(4,1):panelslice(4,2)))];
maxwfmaxpos1064 = [ max(wf1064_max_pos(panelslice(1,1):panelslice(1,2))), ...
                 max(wf1064_max_pos(panelslice(2,1):panelslice(2,2))), ...
                 max(wf1064_max_pos(panelslice(3,1):panelslice(3,2))), ...
                 max(wf1064_max_pos(panelslice(4,1):panelslice(4,2)))];
meanwfmaxpos1064 = [ mean(wf1064_max_pos(panelslice(1,1):panelslice(1,2))), ...
                  mean(wf1064_max_pos(panelslice(2,1):panelslice(2,2))), ...
                  mean(wf1064_max_pos(panelslice(3,1):panelslice(3,2))), ...
                  mean(wf1064_max_pos(panelslice(4,1):panelslice(4,2)))];
medianwfmaxpos1064 = [ median(wf1064_max_pos(panelslice(1,1):panelslice(1,2))), ...
                    median(wf1064_max_pos(panelslice(2,1):panelslice(2,2))), ...
                    median(wf1064_max_pos(panelslice(3,1):panelslice(3,2))), ...
                    median(wf1064_max_pos(panelslice(4,1):panelslice(4,2)))];
stdwfmaxpos1064 = [ std(wf1064_max_pos(panelslice(1,1):panelslice(1,2))), ...
                 std(wf1064_max_pos(panelslice(2,1):panelslice(2,2))), ...
                 std(wf1064_max_pos(panelslice(3,1):panelslice(3,2))), ...
                 std(wf1064_max_pos(panelslice(4,1):panelslice(4,2)))];
% 1548 wf max intensity
minwfmax1548 = [ min(wf1548_max(panelslice(1,1):panelslice(1,2))), ...
                 min(wf1548_max(panelslice(2,1):panelslice(2,2))), ...
                 min(wf1548_max(panelslice(3,1):panelslice(3,2))), ...
                 min(wf1548_max(panelslice(4,1):panelslice(4,2)))];
maxwfmax1548 = [ max(wf1548_max(panelslice(1,1):panelslice(1,2))), ...
                 max(wf1548_max(panelslice(2,1):panelslice(2,2))), ...
                 max(wf1548_max(panelslice(3,1):panelslice(3,2))), ...
                 max(wf1548_max(panelslice(4,1):panelslice(4,2)))];
meanwfmax1548 = [ mean(wf1548_max(panelslice(1,1):panelslice(1,2))), ...
                  mean(wf1548_max(panelslice(2,1):panelslice(2,2))), ...
                  mean(wf1548_max(panelslice(3,1):panelslice(3,2))), ...
                  mean(wf1548_max(panelslice(4,1):panelslice(4,2)))];
medianwfmax1548 = [ median(wf1548_max(panelslice(1,1):panelslice(1,2))), ...
                    median(wf1548_max(panelslice(2,1):panelslice(2,2))), ...
                    median(wf1548_max(panelslice(3,1):panelslice(3,2))), ...
                    median(wf1548_max(panelslice(4,1):panelslice(4,2)))];
stdwfmax1548 = [ std(wf1548_max(panelslice(1,1):panelslice(1,2))), ...
                 std(wf1548_max(panelslice(2,1):panelslice(2,2))), ...
                 std(wf1548_max(panelslice(3,1):panelslice(3,2))), ...
                 std(wf1548_max(panelslice(4,1):panelslice(4,2)))];
% 1548 wf max location, before interpolation
minwfmaxpos1548 = [ min(wf1548_max_pos(panelslice(1,1):panelslice(1,2))), ...
                 min(wf1548_max_pos(panelslice(2,1):panelslice(2,2))), ...
                 min(wf1548_max_pos(panelslice(3,1):panelslice(3,2))), ...
                 min(wf1548_max_pos(panelslice(4,1):panelslice(4,2)))];
maxwfmaxpos1548 = [ max(wf1548_max_pos(panelslice(1,1):panelslice(1,2))), ...
                 max(wf1548_max_pos(panelslice(2,1):panelslice(2,2))), ...
                 max(wf1548_max_pos(panelslice(3,1):panelslice(3,2))), ...
                 max(wf1548_max_pos(panelslice(4,1):panelslice(4,2)))];
meanwfmaxpos1548 = [ mean(wf1548_max_pos(panelslice(1,1):panelslice(1,2))), ...
                  mean(wf1548_max_pos(panelslice(2,1):panelslice(2,2))), ...
                  mean(wf1548_max_pos(panelslice(3,1):panelslice(3,2))), ...
                  mean(wf1548_max_pos(panelslice(4,1):panelslice(4,2)))];
medianwfmaxpos1548 = [ median(wf1548_max_pos(panelslice(1,1):panelslice(1,2))), ...
                    median(wf1548_max_pos(panelslice(2,1):panelslice(2,2))), ...
                    median(wf1548_max_pos(panelslice(3,1):panelslice(3,2))), ...
                    median(wf1548_max_pos(panelslice(4,1):panelslice(4,2)))];
stdwfmaxpos1548 = [ std(wf1548_max_pos(panelslice(1,1):panelslice(1,2))), ...
                 std(wf1548_max_pos(panelslice(2,1):panelslice(2,2))), ...
                 std(wf1548_max_pos(panelslice(3,1):panelslice(3,2))), ...
                 std(wf1548_max_pos(panelslice(4,1):panelslice(4,2)))];

% now print all the stats to the console screen
fprintf('==============================================\n')
fprintf('Stats of returns from the calibration panels: \n');
fprintf(['Calibration data file: ', filelist{fileind}, '\n']);
fprintf('----------------------------------------------\n');
fprintf('----------- 1064 nm Wf Max Stats: ------------\n');
fprintf('Panel,\tMin,\tMax,\tMean,\tMedian,\tSD\n');
fprintf('%s,\t%d,\t%d,\t%.3f,\t%d,\t%.3f\n', ...
       'Lambt', minwfmax1064(1), maxwfmax1064(1), meanwfmax1064(1), medianwfmax1064(1), ...
       stdwfmax1064(1), ...
       'Grey 1', minwfmax1064(2), maxwfmax1064(2), meanwfmax1064(2), medianwfmax1064(2), ...
       stdwfmax1064(2), ...
       'Grey 2', minwfmax1064(3), maxwfmax1064(3), meanwfmax1064(3), medianwfmax1064(3), ...
       stdwfmax1064(3), ...
       'Black', minwfmax1064(4), maxwfmax1064(4), meanwfmax1064(4), medianwfmax1064(4), ...
       stdwfmax1064(4) );
fprintf('----------------------------------------------\n');
fprintf('----------- 1064 nm Wf Loc Stats: ------------\n');
fprintf('Panel,\tMin,\tMax,\tMean,\tMedian,\tSD\n');
fprintf('%s,\t%d,\t%d,\t%.3f,\t%d,\t%.3f\n', ...
        'Lambt', minwfmaxpos1064(1), maxwfmaxpos1064(1), meanwfmaxpos1064(1), ...
        medianwfmaxpos1064(1), stdwfmaxpos1064(1), ...
        'Grey 1', minwfmaxpos1064(2), maxwfmaxpos1064(2), meanwfmaxpos1064(2), ...
        medianwfmaxpos1064(2), stdwfmaxpos1064(2), ...
        'Grey 2', minwfmaxpos1064(3), maxwfmaxpos1064(3), meanwfmaxpos1064(3), ...
        medianwfmaxpos1064(3), stdwfmaxpos1064(3), ...
        'Black', minwfmaxpos1064(4), maxwfmaxpos1064(4), meanwfmaxpos1064(4), ...
        medianwfmaxpos1064(4), stdwfmaxpos1064(4) );
fprintf('----------------------------------------------\n');
fprintf('----------- 1548 nm Wf Max Stats: ------------\n');
fprintf('Panel,\tMin,\tMax,\tMean,\tMedian,\tSD\n');
fprintf('%s,\t%d,\t%d,\t%.3f,\t%d,\t%.3f\n', ...
       'Lambt', minwfmax1548(1), maxwfmax1548(1), meanwfmax1548(1), medianwfmax1548(1), ...
       stdwfmax1548(1), ...
       'Grey 1', minwfmax1548(2), maxwfmax1548(2), meanwfmax1548(2), medianwfmax1548(2), ...
       stdwfmax1548(2), ...
       'Grey 2', minwfmax1548(3), maxwfmax1548(3), meanwfmax1548(3), medianwfmax1548(3), ...
       stdwfmax1548(3), ...
       'Black', minwfmax1548(4), maxwfmax1548(4), meanwfmax1548(4), medianwfmax1548(4), ...
       stdwfmax1548(4) );
fprintf('----------------------------------------------\n');
fprintf('----------- 1548 nm Wf Loc Stats: ------------\n');
fprintf('Panel,\tMin,\tMax,\tMean,\tMedian,\tSD\n');
fprintf('%s,\t%d,\t%d,\t%.3f,\t%d,\t%.3f\n', ...
        'Lambt', minwfmaxpos1548(1), maxwfmaxpos1548(1), meanwfmaxpos1548(1), ...
        medianwfmaxpos1548(1), stdwfmaxpos1548(1), ...
        'Grey 1', minwfmaxpos1548(2), maxwfmaxpos1548(2), meanwfmaxpos1548(2), ...
        medianwfmaxpos1548(2), stdwfmaxpos1548(2), ...
        'Grey 2', minwfmaxpos1548(3), maxwfmaxpos1548(3), meanwfmaxpos1548(3), ...
        medianwfmaxpos1548(3), stdwfmaxpos1548(3), ...
        'Black', minwfmaxpos1548(4), maxwfmaxpos1548(4), meanwfmaxpos1548(4), ...
        medianwfmaxpos1548(4), stdwfmaxpos1548(4) );