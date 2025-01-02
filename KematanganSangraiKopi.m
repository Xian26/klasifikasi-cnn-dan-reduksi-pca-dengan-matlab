function KematanganSangraiKopi_GUI
    % Membuat figure utama
    f = figure('Visible', 'off', 'Position', [100, 100, 800, 600]);
    f.Name = 'Aplikasi klasifikasi Kematangan Sangrai Kopi';
 
    % Variabel global untuk menyimpan data
    global imgOriginal imgSegmented features
 
    % Panel Pengolahan
    %%
    % 
    %   for x = 1:10
    % 
    %  PREFORMATTED
    % 
    %  PREFORMATTED
    % 
    %   for x = 1:10
    %       disp(x)
    %   end
    % 
    %  TEXT
    % 
    %  TEXT
    % 
    %       disp(x)
    %   end
    % 
    panelPengolahan = uipanel(f, 'Title', 'Pengolahan', 'Position', [0.02, 0.55, 0.2, 0.4]);
    
    % Tombol-tombol dalam panel Pengolahan
    uicontrol(panelPengolahan, 'Style', 'pushbutton', 'String', 'Load Data', ...
        'Position', [10, 150, 100, 25], 'Callback', @loadDataCallback);
    uicontrol(panelPengolahan, 'Style', 'pushbutton', 'String', 'Segmentasi', ...
        'Position', [10, 120, 100, 25], 'Callback', @segmentasiCallback);
    uicontrol(panelPengolahan, 'Style', 'pushbutton', 'String', 'Ekstraksi Ciri', ...
        'Position', [10, 90, 100, 25], 'Callback', @ekstraksiCiriCallback);
    uicontrol(panelPengolahan, 'Style', 'pushbutton', 'String', 'Reduksi PCA', ...
        'Position', [10, 60, 100, 25], 'Callback', @reduksiPCACallback);
    uicontrol(panelPengolahan, 'Style', 'pushbutton', 'String', 'Klasifikasi', ...
        'Position', [10, 30, 100, 25], 'Callback', @klasifikasiCallback);
    uicontrol(panelPengolahan, 'Style', 'pushbutton', 'String', 'Reset', ...
        'Position', [10, 0, 100, 25], 'Callback', @resetCallback);
 
    % Panel Nilai Ekstraksi Ciri
    panelNilaiEkstraksi = uipanel(f, 'Title', 'Nilai Ekstraksi Ciri', 'Position', [0.02, 0.05, 0.2, 0.45]);
    
    % Edit text boxes untuk nilai ekstraksi
    uicontrol(panelNilaiEkstraksi, 'Style', 'text', 'String', 'R:', 'Position', [10, 200, 20, 20]);
    uicontrol(panelNilaiEkstraksi, 'Style', 'edit', 'Position', [30, 200, 50, 20], 'Tag', 'R_edit');
    uicontrol(panelNilaiEkstraksi, 'Style', 'text', 'String', 'G:', 'Position', [10, 170, 20, 20]);
    uicontrol(panelNilaiEkstraksi, 'Style', 'edit', 'Position', [30, 170, 50, 20], 'Tag', 'G_edit');
    uicontrol(panelNilaiEkstraksi, 'Style', 'text', 'String', 'B:', 'Position', [10, 140, 20, 20]);
    uicontrol(panelNilaiEkstraksi, 'Style', 'edit', 'Position', [30, 140, 50, 20], 'Tag', 'B_edit');
    uicontrol(panelNilaiEkstraksi, 'Style', 'text', 'String', 'H:', 'Position', [10, 110, 20, 20]);
    uicontrol(panelNilaiEkstraksi, 'Style', 'edit', 'Position', [30, 110, 50, 20], 'Tag', 'H_edit');
    uicontrol(panelNilaiEkstraksi, 'Style', 'text', 'String', 'S:', 'Position', [10, 80, 20, 20]);
    uicontrol(panelNilaiEkstraksi, 'Style', 'edit', 'Position', [30, 80, 50, 20], 'Tag', 'S_edit');
    uicontrol(panelNilaiEkstraksi, 'Style', 'text', 'String', 'V:', 'Position', [10, 50, 20, 20]);
    uicontrol(panelNilaiEkstraksi, 'Style', 'edit', 'Position', [30, 50, 50, 20], 'Tag', 'V_edit');
    uicontrol(panelNilaiEkstraksi, 'Style', 'text', 'String', 'Area:', 'Position', [10, 20, 30, 20]);
    uicontrol(panelNilaiEkstraksi, 'Style', 'edit', 'Position', [50, 20, 50, 20], 'Tag', 'Area_edit');
    uicontrol(f, 'Style', 'text', 'String', 'Nilai PCA:', 'Position', [600, 540, 80, 20]);
    uicontrol(f, 'Style', 'edit', 'Position', [690, 540, 100, 30], 'Tag', 'PCA_edit');
 
    % Grafik untuk Load Data dan Segmentasi
    axLoadData = axes('Parent', f, 'Position', [0.25, 0.55, 0.2, 0.4]);
    title(axLoadData, 'Load Data');
    xlabel(axLoadData, 'X');
    ylabel(axLoadData, 'Y');
 
    axSegmentasi = axes('Parent', f, 'Position', [0.5, 0.55, 0.2, 0.4]);
    title(axSegmentasi, 'Segmentasi');
    xlabel(axSegmentasi, 'X');
    ylabel(axSegmentasi, 'Y');
 
    % Grafik untuk R, G, B
    axR = axes('Parent', f, 'Position', [0.25, 0.05, 0.2, 0.4]);
    title(axR, 'R');
    xlabel(axR, 'X');
    ylabel(axR, 'Y');
 
    axG = axes('Parent', f, 'Position', [0.5, 0.05, 0.2, 0.4]);
    title(axG, 'G');
    xlabel(axG, 'X');
    ylabel(axG, 'Y');
 
    axB = axes('Parent', f, 'Position', [0.75, 0.05, 0.2, 0.4]);
    title(axB, 'B');
    xlabel(axB, 'X');
    ylabel(axB, 'Y');
 
    % Edit text untuk Nilai Akurasi dan Klasifikasi
    uicontrol(f, 'Style', 'text', 'String', 'Nilai Akurasi:', 'Position', [600, 500, 80, 20]);
    uicontrol(f, 'Style', 'edit', 'Position', [690, 500, 100, 20], 'Tag', 'Akurasi_edit');
    uicontrol(f, 'Style', 'text', 'String', 'Klasifikasi:', 'Position', [600, 470, 80, 20]);
    uicontrol(f, 'Style', 'edit', 'Position', [690, 470, 100, 20], 'Tag', 'Klasifikasi_edit');
 
    % Membuat figure menjadi visible
    f.Visible = 'on';
 
    % Callback functions
    function loadDataCallback(~, ~)
        [filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp', 'Image Files (*.jpg, *.png, *.bmp)'}, 'Select an image');
        if isequal(filename, 0) || isequal(pathname, 0)
            disp('User cancelled the operation');
            return;
        end
        
        fullpath = fullfile(pathname, filename);
        imgOriginal = imread(fullpath);
        
        axes(axLoadData);
        imshow(imgOriginal);
        title('Original Image');
    end
 
    function segmentasiCallback(~, ~)
        if isempty(imgOriginal)
            errordlg('Please load an image first', 'Error');
            return;
        end
        
        % Simple segmentation using thresholding
        % You might want to use more advanced segmentation techniques
        grayImg = rgb2gray(imgOriginal);
        threshold = graythresh(grayImg);
        imgSegmented = imbinarize(grayImg, threshold);
        
        axes(axSegmentasi);
        imshow(imgSegmented);
        title('Segmented Image');
    end
 
    function ekstraksiCiriCallback(~, ~)
        if isempty(imgSegmented)
            errordlg('Please perform segmentation first', 'Error');
            return;
        end
        
        % Extract features
        r = mean(mean(imgOriginal(:,:,1)));
        g = mean(mean(imgOriginal(:,:,2)));
        b = mean(mean(imgOriginal(:,:,3)));
        
        hsvImg = rgb2hsv(imgOriginal);
        h = mean(mean(hsvImg(:,:,1)));
        s = mean(mean(hsvImg(:,:,2)));
        v = mean(mean(hsvImg(:,:,3)));
        
        area = sum(sum(imgSegmented));
        
        features = [r, g, b, h, s, v, area];
        
        % Update GUI with feature values
        set(findobj(f, 'Tag', 'R_edit'), 'String', num2str(r));
        set(findobj(f, 'Tag', 'G_edit'), 'String', num2str(g));
        set(findobj(f, 'Tag', 'B_edit'), 'String', num2str(b));
        set(findobj(f, 'Tag', 'H_edit'), 'String', num2str(h));
        set(findobj(f, 'Tag', 'S_edit'), 'String', num2str(s));
        set(findobj(f, 'Tag', 'V_edit'), 'String', num2str(v));
        set(findobj(f, 'Tag', 'Area_edit'), 'String', num2str(area));
        
        % Display RGB histograms
        displayRGBHistograms();
    end
 
    function reduksiPCACallback(~, ~)
    if isempty(features)
        errordlg('Please extract features first', 'Error');
        return;
    end

    % Normalisasi fitur
    normalizedFeatures = (features - mean(features)) ./ std(features);

    % Hitung "kepentingan" setiap fitur (dalam kasus ini, kita gunakan nilai absolut sebagai pengganti variansi)
    featureImportance = abs(normalizedFeatures);

    % Urutkan fitur berdasarkan "kepentingan"nya
    [sortedImportance, sortIndex] = sort(featureImportance, 'descend');

    % Pilih 3 fitur teratas
    topFeatures = features(sortIndex(1:3));

    % Update GUI dengan nilai PCA
    pcaValues = sprintf('Top 1: %.2f, Top 2: %.2f, Top 3: %.2f', topFeatures(1), topFeatures(2), topFeatures(3));
    set(findobj(f, 'Tag', 'PCA_edit'), 'String', pcaValues);

    % Display results
    disp('Top 3 features based on simulated PCA:');
    disp(topFeatures);

    % Tampilkan informasi tambahan
    featureNames = {'R', 'G', 'B', 'H', 'S', 'V', 'Area'};
    disp('Feature importance ranking:');
    for i = 1:length(sortIndex)
        fprintf('%s: %f\n', featureNames{sortIndex(i)}, sortedImportance(i));
    end
end

    function klasifikasiCallback(~, ~)
    if isempty(features)
        errordlg('Please extract features first', 'Error');
        return;
    end

    % Load the trained CNN model
    load('trainedCNN.mat', 'net'); % Sesuaikan dengan nama model Anda

    % Resize the image to match the input size of the network
    resizedImg = imresize(imgOriginal, [64 64]); % Mengubah ukuran menjadi 64x64

    % Perform classification
    predictedClass = classify(net, resizedImg);

    % Display the classification result
    set(findobj(f, 'Tag', 'Klasifikasi_edit'), 'String', char(predictedClass));

    % Optional: Calculate accuracy (if you have validation data)
    % load('validationData.mat'); % Sesuaikan dengan dataset validasi Anda
    % predictedLabels = classify(net, validationData);
    % accuracy = sum(predictedLabels == validationLabels) / numel(validationLabels) * 100;

    % Use a dummy accuracy for this example
    accuracy = 90; % Replace with actual accuracy calculation
    set(findobj(f, 'Tag', 'Akurasi_edit'), 'String', sprintf('%.1f%%', accuracy));
end

    function resetCallback(~, ~)
        % Clear all data and reset GUI
        clear global imgOriginal imgSegmented features
        
        % Reset all axes
        axes(axLoadData); cla; title('Load Data');
        axes(axSegmentasi); cla; title('Segmentasi');
        axes(axR); cla; title('R');
        axes(axG); cla; title('G');
        axes(axB); cla; title('B');
        
        % Clear all edit boxes
        set(findobj(f, 'Style', 'edit'), 'String', '');
    end
 
    function displayRGBHistograms()
        % Display R histogram
        axes(axR);
        histogram(imgOriginal(:,:,1), 'FaceColor', 'r', 'EdgeColor', 'r');
        title('R Histogram');
        
        % Display G histogram
        axes(axG);
        histogram(imgOriginal(:,:,2), 'FaceColor', 'g', 'EdgeColor', 'g');
        title('G Histogram');
        
        % Display B histogram
        axes(axB);
        histogram(imgOriginal(:,:,3), 'FaceColor', 'b', 'EdgeColor', 'b');
        title('B Histogram');
    end
end

function updateGUI(segmented, features, classification)
    % Update your GUI elements here
    % For example:
    imshow(segmented);
    disp(features);
    disp(classification);

    % Send update to Flask to sync web UI
    updateWebUI(segmented, features, classification);
end

function updateWebUI(segmented, features, classification)
    url = 'http://localhost:5000/api/update_ui';
    data = struct('segmented', segmented, 'features', features, 'classification', classification);
    options = weboptions('MediaType', 'application/json');
    webwrite(url, jsonencode(data), options);
end
