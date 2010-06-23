function fig2jpg(figdirectory)
%%Convert any fig files into the jpg and save them into the same directory
% figdirectory: path to the directory 

%     figdirectory = 'C:\Documents and Settings\rchit\Desktop'
    fullpath = sprintf('%s/*.fig',figdirectory);
    d = dir(fullpath);
    length_d = length(d);
    if(length_d == 0)
        disp('couldnt read the directory details');
        disp('check if your files are in correct directory');
    end

    startfig  = 1;
    endfig = length_d;

    for i = startfig:endfig
        [~,fname,~,~] = fileparts(d(i).name);
        fname_input = sprintf('%s/%s',figdirectory,fname);
        fname_output =  sprintf('%s/%s.jpg',figdirectory,fname);
        saveas(openfig(fname_input),fname_output,'jpg');
    end
    close all;
end