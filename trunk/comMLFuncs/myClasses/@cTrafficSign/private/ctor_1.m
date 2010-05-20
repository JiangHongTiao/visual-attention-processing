function this = ctor_1(this, in_arg_1)
%CTOR_1 for class cTrafficSign
%
% function this = ctor_1(this, in_arg_1)
%
% Input Arguments::
%
% in_arg_1: no type info: no description provided
%
% A class_wizard v 3.0 assembled file, generated: 20-Jan-2010 01:18:15
%

if isa(in_arg_1, 'cTrafficSign')  % address copy constructor separately
    this = in_arg_1;  % let MATLAB do the copy assignment
else
    % \/  \/  \/  \/
    % develop if-else and code for 1-argument constructor other than copy constructor
    warning('OOP:incompleteFunction', 'The function definition is incomplete');
    % /\  /\  /\  /\
end
