function col_data = colormap_selection(name)
%% ���ܣ�����ɫ��
%ʹ�����ӣ�
%colormap(colormap_selection('MPL_Blues'));
%��ȡɫ������
filename = [name '.txt'];
col_data = importdata(filename);
col_data = col_data/255;
