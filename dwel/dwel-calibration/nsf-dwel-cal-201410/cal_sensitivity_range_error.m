%% Explore the sensitivity of AppRefl on errors of range and intensity
% 1. assume reflectance is one, no intensity error, add range error to ranges,
% and then simulate the error in apparent reflectance.  2. assume reflectance is
% one, no range error, add intensity error to ranges, and then simulate the
% error in apparent reflectance.

% calibration parameter
% [c0, c1/c4, c2, c3, b]
% calpar1064 = [5863.906,3413.743,0.895,15.640,1.402];
% calpar1548 = [20543.960,5.133,0.646,1.114,1.566];

% cal-20140812-v20140202, simul-app-ndi
calpar1064 = [6591.895,15944.611,0.728,23.998,1.451];
calpar1548 = [14207.522,12.125,0.641,4.486,1.451];

figsize = [0, 0, 6, 4];

% 1064 nm
% ==============================================================================
% no range error, apprefl error against intensity error
% set up range
r = 0.5:0.1:70;
% set intensity errors
int_delta = -15:1:15;
[r_mesh, int_delta_mesh] = meshgrid(r, int_delta);
kr_mesh = gm_func(r_mesh, calpar1064(2), calpar1064(3), calpar1064(4), calpar1064(2));
rhoerr_mesh = int_delta_mesh.*r_mesh.^calpar1064(5)./kr_mesh/calpar1064(1);
rhoerr_int_mesh = rhoerr_mesh;
figure('Position', figsize);
imagesc(r, int_delta, rhoerr_mesh);
colormap('jet');
xlabel('range, meter');
ylabel('return intensity error, DN');
title('1064');
caxis([-0.15, 0.15]);
hold on;
hcb = colorbar('southoutside');
% htitle = get(hcb, 'Title');
% set(htitle, 'String', 'relative error in apparent reflectance');
% pos = get(htitle, 'position');
% pos(2) = pos(2)-7.5;
% set(htitle, 'position', pos);
export_fig('cal_dwel_gm_20140812_1064_sensitivity_intensity_error.png', '-r300', '-png', '-painters');
% plot error over range at +5 DN error
tmpflag = int_delta_mesh(:, 1)==5;
figure('Position', figsize);
plot(r, rhoerr_int_mesh(tmpflag, :))
fprintf('1064, error from int uncertainty, min=%.3f, max=%.3f\n', min(rhoerr_int_mesh(:)), max(rhoerr_int_mesh(:)));

% no intensity error, apprefl error against range error
% set up range
r = 0.5:0.1:70;
% set up range errors
r_delta = -0.15:0.01:0.15;
[r_mesh, r_delta_mesh] = meshgrid(r, r_delta);
kr_mesh = gm_func(r_mesh, calpar1064(2), calpar1064(3), calpar1064(4), calpar1064(2));
intcorr = calpar1064(1)*1*kr_mesh./r_mesh.^calpar1064(5);
rwrg_mesh = r_mesh+r_delta_mesh;
krwrg_mesh = gm_func(rwrg_mesh, calpar1064(2), calpar1064(3), calpar1064(4), calpar1064(2));
rho = intcorr.*rwrg_mesh.^calpar1064(5)./krwrg_mesh/calpar1064(1);
rhoerr_mesh = rho - ones(size(rho));
rhoerr_r_mesh = rhoerr_mesh;
% save rhoerr of 1064 for later investigation of SR and NDI error
rhoerr_r_mesh_1064 = rhoerr_r_mesh;
figure('Position', figsize);
him = imagesc(r, r_delta*100, rhoerr_mesh);
cmap = colormap(jet(32));
caxis([-0.15, 0.15]);
% maxabsrhoerr = max(abs(rhoerr_mesh(:)));
% alpha_mesh = abs(rhoerr_mesh)/maxabsrhoerr;
% alpha_mesh(rhoerr_mesh>0) = 0.3;
% set(him, 'AlphaData', alpha_mesh);

% cmaplb = cmap(1, :);
% cmapub = cmap(end, :);
% minerr = min(rhoerr_mesh(:));
% maxerr = max(rhoerr_mesh(:));
% errlb = -0.15;
% errub = 0.25;
% lbextra = floor(size(cmap, 1)/(errub-errlb)*(errlb - minerr));
% ubextra = floor(size(cmap, 1)/(errub-errlb)*(maxerr - errub));
% cmap = [repmat(cmaplb, lbextra, 1); cmap; repmat(cmapub, ubextra, 1)];
% colormap(cmap);

xlabel('range, meter');
ylabel('range error, centimeter');
title('1064');
hold on;
hcb = colorbar('southoutside');
% htitle = get(hcb, 'Title');
% set(htitle, 'String', 'relative error in apparent reflectance');
% pos = get(htitle, 'position');
% pos(2) = pos(2)-7.5;
% set(htitle, 'position', pos);
export_fig('cal_dwel_gm_20140812_1064_sensitivity_range_error.png', '-r300', '-png', '-painters');
% plot error over range at +5 DN error
tmpflag = 21;
figure('Position', figsize);
plot(r, rhoerr_r_mesh(tmpflag, :))
fprintf('1064, error from range uncertainty, min=%.3f, max=%.3f\n', min(rhoerr_r_mesh(:)), max(rhoerr_r_mesh(:)));


% 1548 nm
% ==============================================================================
% no range error, apprefl error against intensity error
% set up range
r = 0.5:0.1:70;
% set intensity errors
int_delta = -15:1:15;
[r_mesh, int_delta_mesh] = meshgrid(r, int_delta);
kr_mesh = gm_func(r_mesh, calpar1548(2), calpar1548(3), calpar1548(4), calpar1548(2));
rhoerr_mesh = int_delta_mesh.*r_mesh.^calpar1548(5)./kr_mesh/calpar1548(1);
rhoerr_int_mesh = rhoerr_mesh;
figure('Position', figsize);
imagesc(r, int_delta, rhoerr_mesh);
colormap('jet');
xlabel('range, meter');
ylabel('return intensity error, DN');
title('1548');
caxis([-0.15, 0.15]);
hold on;
hcb = colorbar('southoutside');
% htitle = get(hcb, 'Title');
% set(htitle, 'String', 'relative error in apparent reflectance');
% pos = get(htitle, 'position');
% pos(2) = pos(2)-7.5;
% set(htitle, 'position', pos);
export_fig('cal_dwel_gm_20140812_1548_sensitivity_intensity_error.png', '-r300', '-png', '-painters');
% plot error over range at +5 DN error
tmpflag = int_delta_mesh(:, 1)==5;
figure('Position', figsize);
plot(r, rhoerr_int_mesh(tmpflag, :))
fprintf('1548, error from int uncertainty, min=%.3f, max=%.3f\n', min(rhoerr_int_mesh(:)), max(rhoerr_int_mesh(:)));

% no intensity error, apprefl error against range error
% set up range
r = 0.5:0.1:70;
% set up range errors
r_delta = -0.15:0.01:0.15;
[r_mesh, r_delta_mesh] = meshgrid(r, r_delta);
kr_mesh = gm_func(r_mesh, calpar1548(2), calpar1548(3), calpar1548(4), calpar1548(2));
intcorr = calpar1548(1)*1*kr_mesh./r_mesh.^calpar1548(5);
rwrg_mesh = r_mesh+r_delta_mesh;
krwrg_mesh = gm_func(rwrg_mesh, calpar1548(2), calpar1548(3), calpar1548(4), calpar1548(2));
rho = intcorr.*rwrg_mesh.^calpar1548(5)./krwrg_mesh/calpar1548(1);
rhoerr_mesh = rho - ones(size(rho));
rhoerr_r_mesh = rhoerr_mesh;
% save rhoerr of 1548 for later investigation of SR and NDI error
rhoerr_r_mesh_1548 = rhoerr_r_mesh;
figure('Position', figsize);
him = imagesc(r, r_delta*100, rhoerr_mesh);
cmap = colormap(jet(32));
caxis([-0.15, 0.15]);
% maxabsrhoerr = max(abs(rhoerr_mesh(:)));
% alpha_mesh = abs(rhoerr_mesh)/maxabsrhoerr;
% alpha_mesh(rhoerr_mesh>0) = 0.3;
% set(him, 'AlphaData', alpha_mesh);

% cmaplb = cmap(1, :);
% cmapub = cmap(end, :);
% minerr = min(rhoerr_mesh(:));
% maxerr = max(rhoerr_mesh(:));
% errlb = -0.15;
% errub = 0.25;
% lbextra = floor(size(cmap, 1)/(errub-errlb)*(errlb - minerr));
% ubextra = floor(size(cmap, 1)/(errub-errlb)*(maxerr - errub));
% cmap = [repmat(cmaplb, lbextra, 1); cmap; repmat(cmapub, ubextra, 1)];
% colormap(cmap);

xlabel('range, meter');
ylabel('range error, centimeter');
title('1548');
hold on;
hcb = colorbar('southoutside');
% htitle = get(hcb, 'Title');
% set(htitle, 'String', 'relative error in apparent reflectance');
% pos = get(htitle, 'position');
% pos(2) = pos(2)-7.5;
% set(htitle, 'position', pos);
export_fig('cal_dwel_gm_20140812_1548_sensitivity_range_error.png', '-r300', '-png', '-painters');
% plot error over range at +5 DN error
tmpflag = 21;
figure('Position', figsize);
plot(r, rhoerr_r_mesh(tmpflag, :))
fprintf('1548, error from range uncertainty, min=%.3f, max=%.3f\n', min(rhoerr_r_mesh(:)), max(rhoerr_r_mesh(:)));


%% sensitivity of SR and NDI on range error
maxrplot = 15; % maximum range to plot
maxrind = find(r>maxrplot);
maxrind = maxrind(1)-1;

srerr_r_mesh = (1+rhoerr_r_mesh_1064)./(1+rhoerr_r_mesh_1548) - 1;
figure('Position', figsize);
him = imagesc(r(1:maxrind), r_delta*100, srerr_r_mesh(:, 1:maxrind));
cmap = colormap(jet(32));
% caxis([-0.15, 0.15]);
xlabel('range, meter');
ylabel('range error, centimeter');
title(['Relative error in SR', char(10), 'same range error in both NIR and SWIR']);
hold on;
hcb = colorbar('southoutside');
export_fig('cal_dwel_gm_20140812_1548_sr_sensitivity_nir_swir_range_error.png', '-r300', '-png', '-painters');

srerr_r_mesh = (1+rhoerr_r_mesh_1064) - 1;
figure('Position', figsize);
him = imagesc(r(1:maxrind), r_delta*100, srerr_r_mesh(:, 1:maxrind));
cmap = colormap(jet(32));
% caxis([-0.15, 0.15]);
xlabel('range, meter');
ylabel('range error, centimeter');
title(['Relative error in SR', char(10), 'range error only in NIR, none in SWIR']);
hold on;
hcb = colorbar('southoutside');
export_fig('cal_dwel_gm_20140812_1548_sr_sensitivity_nir_range_error.png', '-r300', '-png', '-painters');

srerr_r_mesh = 1.0./(1+rhoerr_r_mesh_1548) - 1;
figure('Position', figsize);
him = imagesc(r(1:maxrind), r_delta*100, srerr_r_mesh(:, 1:maxrind));
cmap = colormap(jet(32));
% caxis([-0.15, 0.15]);
xlabel('range, meter');
ylabel('range error, centimeter');
title(['Relative error in SR', char(10), 'range error only in SWIR, none in NIR']);
hold on;
hcb = colorbar('southoutside');
export_fig('cal_dwel_gm_20140812_1548_sr_sensitivity_swir_range_error.png', '-r300', '-png', '-painters');

ndierr_r_mesh = (rhoerr_r_mesh_1064-rhoerr_r_mesh_1548)./(2+rhoerr_r_mesh_1064+rhoerr_r_mesh_1548);
figure('Position', figsize);
him = imagesc(r(1:maxrind), r_delta*100, ndierr_r_mesh(:, 1:maxrind));
cmap = colormap(jet(32));
% caxis([-0.15, 0.15]);
xlabel('range, meter');
ylabel('range error, centimeter');
title(['Absolute Error NDI assuming $\rho_{nir}=\rho_{swir}$ for a lambertian panel,',char(10),'both NIR and SWIR have the same range error']);
hold on;
hcb = colorbar('southoutside');
export_fig('cal_dwel_gm_20140812_1548_ndi_sensitivity_nir_swir_range_error.png', '-r300', '-png', '-painters');
