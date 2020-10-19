clc;
clear;
%����׼��---------------------------------------------------------------------
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

model = im2double(model); % ģ��
[mRows,mCols,mDims] = size(model); % ģ�ͳߴ�

% %�����趨---------------------------------------------------------------------
% % ����ߴ磨�Ƽ�ʹ��Ĭ�����ã���Ȼ������������ã�
% M = max([mRows,mCols,mDims]);
% N = max([mRows,mCols,mDims]);
% % ����ֱ��ʣ��Ƽ�ʹ��Ĭ�����ã���Ȼ������������ã�
% ms = 512;
% ns = 512;
% % ��������
% precison = ([M,N]-1)./([ms,ns]-1);
% % �������ģ��Ƽ�ʹ��Ĭ�����ã���Ȼ������������ã�
% mCenter = ([mRows,mCols,mDims]+1)/2;
% % ������ת�ǣ����������ģ����ܴӲ�ͬ�Ƕȹ۲�Ŀ�꣩
% alpha = 90;
% beta = 90;
% gamma = 0;
% 
% %��������---------------------------------------------------------------------
% % תΪ����
% alpha = alpha/180*pi;
% beta = beta/180*pi;
% gamma = gamma/180*pi;
% % ��ʼ������
% mesh.x = zeros(M,N);
% mesh.y = zeros(M,N);
% mesh.z = zeros(M,N);
% % ��������
% for r = 1:ms
%     for c = 1:ns
%         % ����ֵ
%         x = 1+(r-1)*precison(1);
%         y = 1+(c-1)*precison(2);
%         z = 0;
%         % {������ת}
%         % ����ԭ��
%         x = x-mCenter(1);
%         y = y-mCenter(2);
%         % x����ʱ����ת
%         tmp = [x,y,z]; % ������ת�и���ԭֵ
%         y = tmp(2)*cos(alpha)-tmp(3)*sin(alpha);
%         z = tmp(2)*sin(alpha)+tmp(3)*cos(alpha);
%         % y����ʱ����ת
%         tmp = [x,y,z]; % ������ת�и���ԭֵ
%         x = tmp(1)*cos(beta)+tmp(3)*sin(beta);
%         z = -tmp(1)*sin(beta)+tmp(3)*cos(beta);
%         % z����ʱ����ת
%         tmp = [x,y,z]; % ������ת�и���ԭֵ
%         x = tmp(1)*cos(gamma)-tmp(2)*sin(gamma);
%         y = tmp(1)*sin(gamma)+tmp(2)*cos(gamma);
%         % �ƻ�����
%         mesh.x(r,c) = x+mCenter(1);
%         mesh.y(r,c) = y+mCenter(2);
%         mesh.z(r,c) = z+mCenter(3);
%     end
% end
% 
% %���ݲ���-------------------------------------------------------------------
% im = zeros(ms,ns);
% % ע��Ϊ��ʾԭ��û��ʹ��interp3()����
% for r = 1:ms
%     for c = 1:ns
%         % �˴�ʹ������ڲ�ֵ
%         x = round(mesh.x(r,c));
%         y = round(mesh.y(r,c));
%         z = round(mesh.z(r,c));
%         if x>=1&&x<=mRows && y>=1&&y<=mCols && z>=1&&z<=mDims
%             im(r,c) = model(x,y,z);
%         end
%     end
% end

%XZ
%�����趨---------------------------------------------------------------------
% ����ߴ磨�Ƽ�ʹ��Ĭ�����ã���Ȼ������������ã�
M = 256;
N = 161;
% ����ֱ��ʣ��Ƽ�ʹ��Ĭ�����ã���Ȼ������������ã�
ms = 256;
ns = 344;
% ��������
precison = ([M,N])./([ms,ns]);
mCenter = ([mRows,mCols,mDims]+1)/2;
% ��ʼ������
mesh.x = zeros(M,N);
mesh.z = zeros(M,N);

% ��������
for r = 1:ms
    for c = 1:ns
        % ����ֵ
        x = 1+(r-1)*precison(1);
        y = 0;
        z = 1+(c-1)*precison(2);
        % �ƻ�����
        mesh.x(r,c) = x;
        mesh.z(r,c) = z;
    end
end

%���ݲ���-------------------------------------------------------------------
im = 255*ones(ms,ns);
% ע��Ϊ��ʾԭ��û��ʹ��interp3()����
for r = 1:ms
    for c = 1:ns
        % �˴�ʹ������ڲ�ֵ
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
%�����趨---------------------------------------------------------------------
% ����ߴ磨�Ƽ�ʹ��Ĭ�����ã���Ȼ������������ã�
M = 256;
N = 161;
% ����ֱ��ʣ��Ƽ�ʹ��Ĭ�����ã���Ȼ������������ã�
ms = 256;
ns = 344;
% ��������
precison = ([M,N])./([ms,ns]);
mCenter = ([mRows,mCols,mDims]+1)/2;
% ��ʼ������
mesh.y = zeros(M,N);
mesh.z = zeros(M,N);

% ��������
for r = 1:ms
    for c = 1:ns
        % ����ֵ
        y = 1+(r-1)*precison(1);
        x = 0;
        z = 1+(c-1)*precison(2);
        % �ƻ�����
        mesh.x(r,c) = y;
        mesh.z(r,c) = z;
    end
end

%���ݲ���-------------------------------------------------------------------
im = 255*ones(ms,ns);
% ע��Ϊ��ʾԭ��û��ʹ��interp3()����
for r = 1:ms
    for c = 1:ns
        % �˴�ʹ������ڲ�ֵ
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