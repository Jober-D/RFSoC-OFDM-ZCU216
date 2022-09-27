function blkStruct = slblocks
% This function specifies that the library 'mylib'
% should appear in the Library Browser with the 
% name 'My Library'

    Browser.Library = 'mylib';
%     Browser.Library = 'lib_datainspector';
%     Browser.Library = 'lib_decimaterx';
%     Browser.Library = 'lib_interpolatetx';
%     Browser.Library = 'lib_rfsignalgenerator';
%     Browser.Library = 'ofdmrx';
%     Browser.Library = 'ofdmtx';



    % 'mylib' is the name of the library

    Browser.Name = 'My Lib';
    % 'My Library' is the library name that appears
    % in the Library Browser

    blkStruct.Browser = Browser;