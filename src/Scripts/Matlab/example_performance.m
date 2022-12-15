clear all;

% load remote interface
REMOTE = remotecall(); 

% initialize connection
Con = REMOTE.Init("tcp://127.0.0.1:5555");

% load newly created interface
FUNC = labview_functions(); 

% do a number of times the Send Array function and time execution time
dataArray = 1:1000;
nriter = 1000;
timearray = zeros(nriter,1);
for i = 1:nriter
tic
FUNC.TimingMethods.SendDBL(Con, 1);
%FUNC.TimingMethods.SendArray(Con, dataArray);
time = toc;
timearray(i) =  time*1000;
end
histogram(timearray,50);
mean(timearray)