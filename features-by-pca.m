x = [];
x = [x extract_patches(imread('natural1.jpg'),8,500)];
x = [x extract_patches(imread('natural2.jpg'),8,500)];
x = [x extract_patches(imread('natural3.jpg'),8,500)];
x = [x extract_patches(imread('natural4.jpg'),8,500)];
x = [x extract_patches(imread('natural5.jpg'),8,500)];
x = [x extract_patches(imread('natural6.jpg'),8,500)];
x = [x extract_patches(imread('natural7.jpg'),8,500)];
x = [x extract_patches(imread('natural8.jpg'),8,500)];
x = [x extract_patches(imread('natural9.jpg'),8,500)];
x = [x extract_patches(imread('natural10.jpg'),8,500)];
X = transpose(x);
covX = cov(X,1);
s = svd(covX);
[U,S,V] = svd(covX); 
t = trace(S);

elevenX = extract_patches(imread('natural11.jpg'),8,500);
eX = transpose(elevenX);
ecovX = cov(eX,1);
es = svd(ecovX);
[eU,eS,eV] = svd(ecovX);

% display(t);
% display(t*.99);
figure

plot(cumsum(s));
axis([0,64,0,2.2347e+05]);

figure
colormap('gray');

for idx = 1:10
    subplot(2,5, idx);
    z = U(:,idx);
    
    z = z - min(z);
    z = z / max(z);
    imagesc(reshape(z,8,8));
    set(gca,'xticklabel',[]);
    set(gca,'yticklabel',[]);
    title(sprintf('%0 .5g',(S (idx,idx)/trace(S))*100));
   
end


coeffs = zeros(10,64);


im = imread('natural11.jpg');
[x y] = size(im);
results = zeros(x,y);
step = 8;
numeig = 5;
error = 0;
for idx = 0:(x/step)-1
    for idy = 0:(y/step)-1
        patch = im(((idx*8)+1):((idx+1)*8),((idy*8)+1):((idy+1)*8));
        
        patch =double( reshape(patch, 1,64));
        
        n_patch = zeros(64,1);
 
        for idcoeff = 1:numeig
            dp = dot(patch,U(:,idcoeff));
            coeffs(idcoeff,((floor(idx/8)+1)*(floor(idy/8)+1))) = dp;
            synth = dp * U(:,idcoeff);
            
            n_patch = n_patch + synth;
        end  
        
   
        error = error + (sum (n_patch - transpose(patch))^2)/(sum (patch)^2);
        display(error);
        n_patch = reshape(n_patch,8,8);
        results(((idx*8)+1):((idx+1)*8),((idy*8)+1):((idy+1)*8)) = n_patch;
    end
end

figure
for h = 1:10
 
    hold on;
    subplot(2,5,h);
    title('Histogram Frequency for PC Coefficients:' + 'h');
    line = coeffs(h,:);
    disp(h); disp(std(line));
    hist(line,8);
end

figure
for h = 1:10
 
    hold on;
    subplot(2,5,h);
    title('Histogram Frequency for PC Coefficients:' + 'h');
    line = coeffs(h,:);
    disp(h); disp(std(line));
    hist(line,8);
end

figure
colormap('gray');
imshow(im);
title('Original image');


