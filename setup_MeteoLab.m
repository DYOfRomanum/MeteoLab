function setup_MeteoLab
%% ��Meteolab�������������ǰ·��

%ʹ��˵����
%��Ҫ�Ƚ���ǰ�ļ�������Ϊ������İ�װ·��
%Ȼ��������������setup_MeteoLab���ɽ������������Matlab·��

%��ȡ����·��
get_fullpath = cd;
fullpath = [get_fullpath '\Meteolab'];
hurricane_path = [fullpath '\hurricane'];
%�����MeteoLab·��
addpath(fullpath)
addpath(hurricane_path);
disp('Meteolab added to Matlab path')
