function [identnumber] = Absfname2number(inputstring)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


len=length(inputstring);
if isstrprop(inputstring(1),'alpha')
    datstr=inputstring((len-10):(len-4));

    if str2num(datstr(1))>8
        zweitausend='19';
    else
        zweitausend='20';
    end
    identnumber=str2num([zweitausend datstr(1:4) '.' datstr(5:7)]);
    
else
    identnumber=str2num(['20' inputstring(1:9)]);
end


end

