function setup_MeteoMagician
%% ��MeteoMagician�������������ǰ·��

%ʹ��˵����
%��Ҫ�Ƚ���ǰ�ļ�������Ϊ������İ�װ·��
%Ȼ��������������setup_MeteoMagician���ɽ������������Matlab·��

%��ȡ����·��
get_fullpath = cd;
fullpath = [get_fullpath '\MeteoMagician'];
hurricane_path = [fullpath '\hurricane'];
colormap_path = [fullpath '\colormaps'];
%�����MeteoLab·��
addpath(fullpath)
addpath(hurricane_path);
addpath(colormap_path);
disp('MeteoMagician added to Matlab path')
