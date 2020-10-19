clc;
clear;
%数据准备---------------------------------------------------------------------
M=256;
N=256;
D=161;
model = zeros(M,N,D);
for i=1:D
    filename = ['hyj (',num2str(i),').png'];
    disp(filename);
    aa = imread(filename);
    model(:,:,i) = aa(:,:,1);
end

model = im2double(model); % 模型
[mRows,mCols,mDims] = size(model); % 模型尺寸

% %参数设定---------------------------------------------------------------------
% % 切面尺寸（推荐使用默认设置，当然你可以自行设置）
% M = max([mRows,mCols,mDims]);
% N = max([mRows,mCols,mDims]);
% % 切面分辨率（推荐使用默认设置，当然你可以自行设置）
% ms = 512;
% ns = 512;
% % 采样进度
% precison = ([M,N]-1)./([ms,ns]-1);
% % 切面中心（推荐使用默认设置，当然你可以自行设置）
% mCenter = ([mRows,mCols,mDims]+1)/2;
% % 切面旋转角（这个请随意改，就能从不同角度观察目标）
% alpha = 90;
% beta = 90;
% gamma = 0;
% 
% %网格生成---------------------------------------------------------------------
% % 转为弧度
% alpha = alpha/180*pi;
% beta = beta/180*pi;
% gamma = gamma/180*pi;
% % 初始化网格
% mesh.x = zeros(M,N);
% mesh.y = zeros(M,N);
% mesh.z = zeros(M,N);
% % 计算网格
% for r = 1:ms
%     for c = 1:ns
%         % 赋初值
%         x = 1+(r-1)*precison(1);
%         y = 1+(c-1)*precison(2);
%         z = 0;
%         % {中心旋转}
%         % 移至原点
%         x = x-mCenter(1);
%         y = y-mCenter(2);
%         % x轴逆时针旋转
%         tmp = [x,y,z]; % 避免旋转中覆盖原值
%         y = tmp(2)*cos(alpha)-tmp(3)*sin(alpha);
%         z = tmp(2)*sin(alpha)+tmp(3)*cos(alpha);
%         % y轴逆时针旋转
%         tmp = [x,y,z]; % 避免旋转中覆盖原值
%         x = tmp(1)*cos(beta)+tmp(3)*sin(beta);
%         z = -tmp(1)*sin(beta)+tmp(3)*cos(beta);
%         % z轴逆时针旋转
%         tmp = [x,y,z]; % 避免旋转中覆盖原值
%         x = tmp(1)*cos(gamma)-tmp(2)*sin(gamma);
%         y = tmp(1)*sin(gamma)+tmp(2)*cos(gamma);
%         % 移回中心
%         mesh.x(r,c) = x+mCenter(1);
%         mesh.y(r,c) = y+mCenter(2);
%         mesh.z(r,c) = z+mCenter(3);
%     end
% end
% 
% %数据采样-------------------------------------------------------------------
% im = zeros(ms,ns);
% % 注：为演示原理没有使用interp3()函数
% for r = 1:ms
%     for c = 1:ns
%         % 此处使用最近邻插值
%         x = round(mesh.x(r,c));
%         y = round(mesh.y(r,c));
%         z = round(mesh.z(r,c));
%         if x>=1&&x<=mRows && y>=1&&y<=mCols && z>=1&&z<=mDims
%             im(r,c) = model(x,y,z);
%         end
%     end
% end

%XZ
%参数设定---------------------------------------------------------------------
% 切面尺寸（推荐使用默认设置，当然你可以自行设置）
M = 256;
N = 161;
% 切面分辨率（推荐使用默认设置，当然你可以自行设置）
ms = 256;
ns = 344;
% 采样进度
precison = ([M,N])./([ms,ns]);
mCenter = ([mRows,mCols,mDims]+1)/2;
% 初始化网格
mesh.x = zeros(M,N);
mesh.z = zeros(M,N);

% 计算网格
for r = 1:ms
    for c = 1:ns
        % 赋初值
        x = 1+(r-1)*precison(1);
        y = 0;
        z = 1+(c-1)*precison(2);
        % 移回中心
        mesh.x(r,c) = x;
        mesh.z(r,c) = z;
    end
end

%数据采样-------------------------------------------------------------------
im = 255*ones(ms,ns);
% 注：为演示原理没有使用interp3()函数
for r = 1:ms
    for c = 1:ns
        % 此处使用最近邻插值
        x = round(mesh.x(r,c));
        y = round(mCenter(2));
        z = round(mesh.z(r,c));
        if x>=1&&x<=mRows && y>=1&&y<=mCols && z>=1&&z<=mDims
            im(r,c) = model(x,y,z);
        end
    end
end
figure(1)
imshow(rot90(im,3),[0,255])

%YZ
%参数设定---------------------------------------------------------------------
% 切面尺寸（推荐使用默认设置，当然你可以自行设置）
M = 256;
N = 161;
% 切面分辨率（推荐使用默认设置，当然你可以自行设置）
ms = 256;
ns = 344;
% 采样进度
precison = ([M,N])./([ms,ns]);
mCenter = ([mRows,mCols,mDims]+1)/2;
% 初始化网格
mesh.y = zeros(M,N);
mesh.z = zeros(M,N);

% 计算网格
for r = 1:ms
    for c = 1:ns
        % 赋初值
        y = 1+(r-1)*precison(1);
        x = 0;
        z = 1+(c-1)*precison(2);
        % 移回中心
        mesh.x(r,c) = y;
        mesh.z(r,c) = z;
    end
end

%数据采样-------------------------------------------------------------------
im = 255*ones(ms,ns);
% 注：为演示原理没有使用interp3()函数
for r = 1:ms
    for c = 1:ns
        % 此处使用最近邻插值
        y = round(mesh.x(r,c));
        x = round(mCenter(2));
        z = round(mesh.z(r,c));
        if x>=1&&x<=mRows && y>=1&&y<=mCols && z>=1&&z<=mDims
            im(r,c) = model(x,y,z);
        end
    end
end
figure(2)
imshow(rot90(im,3),[0,255])