function [FUNC] = labview_functions()
FUNC.Console.Clear = @Console_Clear;
FUNC.Console.GetLines = @Console_GetLines;
FUNC.Console.Print = @Console_Print;

FUNC.TimingMethods.SendArray = @TimingMethods_SendArray;
FUNC.TimingMethods.SendComplexCluster = @TimingMethods_SendComplexCluster;
FUNC.TimingMethods.SendDBL = @TimingMethods_SendDBL;
FUNC.TimingMethods.SendVarious = @TimingMethods_SendVarious;

function  Console_Clear (Con) 
% Clear the console of all lines

% input data types
% output data types

RemoteCall = remotecall();
parIn=struct;
[err, parOut] = RemoteCall.Execute(Con, "Console", "Clear", parIn);
if err.status == 1, error (err.source); end

end

function [Lines] = Console_GetLines (Con) 
% Get all the lines currently on the console

% input data types
% output data types
% Lines = jsondecode("""""");

RemoteCall = remotecall();
parIn=struct;
[err, parOut] = RemoteCall.Execute(Con, "Console", "GetLines", parIn);
if err.status == 1, error (err.source); end
Lines = parOut.Lines;

end

function  Console_Print (Con, Line)
% Print a line to the console

% input data types
% Line = jsondecode("""""");
% output data types

RemoteCall = remotecall();
parIn={};
parIn.Line = Line;

[err, parOut] = RemoteCall.Execute(Con, "Console", "Print", parIn);
if err.status == 1, error (err.source); end

end

function [Out] = TimingMethods_SendArray (Con, In)

% input data types
% In = jsondecode("[]");
% output data types
% Out = jsondecode("[]");

RemoteCall = remotecall();
parIn={};
parIn.In = In;

[err, parOut] = RemoteCall.Execute(Con, "TimingMethods", "SendArray", parIn);
if err.status == 1, error (err.source); end
Out = parOut.Out;

end

function [Out] = TimingMethods_SendComplexCluster (Con, In)

% input data types
% In = jsondecode("{""subcl"":{""dbl"":[]},""str"":[],""Array"":[],""Path"":""""}");
% output data types
% Out = jsondecode("{""subcl"":{""dbl"":[]},""str"":[],""Array"":[],""Path"":""""}");

RemoteCall = remotecall();
parIn={};
parIn.In = In;

[err, parOut] = RemoteCall.Execute(Con, "TimingMethods", "SendComplexCluster", parIn);
if err.status == 1, error (err.source); end
Out = parOut.Out;

end

function [Out] = TimingMethods_SendDBL (Con, In)

% input data types
% In = jsondecode("0.00000000000000");
% output data types
% Out = jsondecode("0.00000000000000");

RemoteCall = remotecall();
parIn={};
parIn.In = In;

[err, parOut] = RemoteCall.Execute(Con, "TimingMethods", "SendDBL", parIn);
if err.status == 1, error (err.source); end
Out = parOut.Out;

end

function [Array_Out, Cluster_Out, Boolean_Out] = TimingMethods_SendVarious (Con, Boolean_In, Array_in, Cluster_In)

% input data types
% Boolean_In = jsondecode("true");
% Array_in = jsondecode("[]");
% Cluster_In = jsondecode("{""subcl"":{""dbl"":[]},""str"":[],""Array"":[],""Path"":""""}");
% output data types
% Array_Out = jsondecode("[]");
% Cluster_Out = jsondecode("{""subcl"":{""dbl"":[]},""str"":[],""Array"":[],""Path"":""""}");
% Boolean_Out = jsondecode("true");

RemoteCall = remotecall();
parIn={};
parIn.Boolean_In = Boolean_In;
parIn.Array_in = Array_in;
parIn.Cluster_In = Cluster_In;

[err, parOut] = RemoteCall.Execute(Con, "TimingMethods", "SendVarious", parIn);
if err.status == 1, error (err.source); end
Array_Out = parOut.Array_Out;
Cluster_Out = parOut.Cluster_Out;
Boolean_Out = parOut.Boolean_Out;

end


end