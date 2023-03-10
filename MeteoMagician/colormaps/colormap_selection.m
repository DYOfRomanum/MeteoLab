function col_data = colormap_selection(name)
%% 功能：更换色卡
%使用例子：
%colormap(colormap_selection('MPL_Blues'));
%读取色卡数据
filename = [name '.txt'];
col_data = importdata(filename);
col_data = col_data/255;
