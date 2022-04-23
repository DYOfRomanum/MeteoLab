function setup_MeteoLab
%% 将Meteolab工具箱添加至当前路径

%使用说明：
%需要先将当前文件夹设置为工具箱的安装路径
%然后在命令行输入setup_MeteoLab即可将工具箱添加至Matlab路径

%获取绝对路径
get_fullpath = cd;
fullpath = [get_fullpath '\Meteolab'];
hurricane_path = [fullpath '\hurricane'];
%添加至MeteoLab路径
addpath(fullpath)
addpath(hurricane_path);
disp('Meteolab added to Matlab path')
