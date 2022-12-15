clear all;

% load remote interface
REMOTE = remotecall(); 

% initialize connection
Con = REMOTE.Init("tcp://127.0.0.1:5555");

% load newly created interface
FUNC = labview_functions(); 

% Call the hello world
FUNC.Console.Print("Hello World")