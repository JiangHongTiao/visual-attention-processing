function dataStructure()
%%Data structure of fixation in faces database
% The fixations struct contains the following data for each image:
% sbj{i} - subject number (1-9)
% ... .age - subject age at the time they participated in the experiment
% ... .sex - m - male; f - female
% ... .response - an array (1-200) of numbers corresponding to the subject rating of the image (1-9); ordered by imgList
% ... .order - the order by which the images were seen by the subject in the actual experiment.
% Example: find(sbj{1}.order == 16) returns 159, indicating that the 159th image the subject saw was imgList{16}.
% ... .scan{j} - scanpath for each image (1-200). The corresponding images names are listed in imgList{j}
% ... ... .fix_x - the x location of the fixations (number of fixations vary per image. fix_x(2) refers to the second fixation.
% ... ... .fix_y - the y location of the fixations
% ... ... .fix_duration - the duration (in milliseconds) of each fixation.
% ... ... .scan_x - the x location of the saccade. We acquired for 2 seconds at 1000Hz.
% ... ... .scan_y - the y location of the saccade.
% 
% The imgList struct contains the following data for each image:
% imgList{i} - the name of the image (1-200).
% 
% The annotations struct contains the following data for each image:
% annotations{i} - the annotation of the image, corresponding to imgList{i}.
% ... .objects{j} - the object annotations (number of objects in each image vary)
% ... ... .name - the labeling of the object ('Face','Phone','Banana', etc.)
% ... ... .x - the x location of the edges of the annotated object.
% ... ... .y - the y location of the edges of the annotated object.
end