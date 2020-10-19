clc;
clear;

% I1 = imread('10.bmp')
% I2 = dicomread( '00000010.dcm') 
% info1 = dicominfo( '00000010.dcm')
% II = dicomwrite(I1, '10.dcm',info1,'CreateMode','copy')
% I3 = dicomread( '10.dcm') 
% I4 = dicomread( '00000011.dcm') 
% info2 = dicominfo( '00000011.dcm')

info = dicominfo( '00000010.dcm')

D=161;

for i=1:D
    filename = [num2str(i),'.bmp'];
    info.InstanceNumber = i;
    info.ImageIndex = i;
    I = imread(filename);
    filename1 = ['DICOM/', num2str(i),'.dcm'];
    dicomwrite(I, filename1, info,'CreateMode','copy')
end

