function setup_MeteoLab
%% ��Meteolab�������������ǰ·��

%ʹ��˵����
%��Ҫ�Ƚ���ǰ�ļ�������Ϊ������İ�װ·��
%Ȼ��������������setup_MeteoLab���ɽ������������Matlab·��

%��ȡ����·��
get_fullpath = cd;
fullpath = [get_fullpath '\Meteolab'];
%�����MeteoLab·��
addpath(fullpath)
disp('Meteolab added to Matlab path')