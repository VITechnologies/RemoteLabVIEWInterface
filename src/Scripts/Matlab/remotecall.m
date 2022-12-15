function [REM] = remotecall()
    REM = {};
    REM.Init = @Init;
    REM.ReadClasses = @ReadClasses;
    REM.ReadMethods = @ReadMethods;
    REM.ReadParameters = @ReadParameters;
    REM.Execute = @Execute;
    REM.ToMatlab = @ToMatlab;
end



function Con = Init(ipAddress)


    NET.addAssembly(fullfile(pwd,".\zeromq.dll"));

    Cxt = ZeroMQ.ZContext();

    Con = ZeroMQ.ZSocket(Cxt,ZeroMQ.ZSocketType.REQ);

    Con.Connect(ipAddress);
    
end

function [err, classes] = ReadClasses(Con)
    Frame = ZeroMQ.ZFrame("{ ""Command"":""ReadClasses"" }");

    Con.Send(Frame);

    Rec = Con.ReceiveFrame();

    txt = Rec.ReadString();
    
    newstr = split(string(txt),"");

    data = jsondecode(string(newstr(1)));
    err = jsondecode(string(newstr(2)));
    
    classes = data.Data.Classes; 
end

function [err, methods] = ReadMethods(Con, className )

    tekst = sprintf ("{ ""Command"":""ReadMethods"" }{""ClassLabel"":""%s""}", className);
    Frame = ZeroMQ.ZFrame(tekst);

      
    Con.Send(Frame);

    Rec = Con.ReceiveFrame();

    txt = Rec.ReadString();
    
    newstr = split(string(txt),"");

    data = jsondecode(string(newstr(1)));
    err = jsondecode(string(newstr(2)));
    methods = data.Methods.Methods;
end

%function [parNamesIn, parNamesOut, parIn, parOut] = ReadParameters(Con, className, method )
function [err, parIn, parOut] = ReadParameters(Con, className, method )


    tekst = sprintf ("{ ""Command"":""ReadParameters"" }{""ClassLabel"":""%s"",""Method"":""%s""}", className, method);
    Frame = ZeroMQ.ZFrame(tekst);

      
    Con.Send(Frame);

    Rec = Con.ReceiveFrame();

    txt = Rec.ReadString();

    newstr = split(string(txt),"");
    
    parIn = {};
    parOut = {};
    parIn = jsondecode(string(newstr(1)));
    parOut = jsondecode(string(newstr(2)));
    err = jsondecode(string(newstr(3)));
   
    
%    parNames = jsondecode(string(newstr(1)));
%    parIn = jsondecode(string(newstr(2)));
%    parOut = jsondecode(string(newstr(3)));
    
%    parNamesIn = parNames.In;
 %   parNamesOut = parNames.Out;
 %       
    
    
end

function [err, parOut] = Execute(Con, className, method, parIn )

    in = {};
    in(1).In = parIn;
    parInTxt = jsonencode(in);
    tekst = sprintf ("{ ""Command"":""Execute"" }{""ClassLabel"":""%s"",""Method"":""%s""}%s", className, method, parInTxt );
    Frame = ZeroMQ.ZFrame(tekst);
      
    Con.Send(Frame);

    Rec = Con.ReceiveFrame();

    txt = Rec.ReadString();

    newstr = split(string(txt),"");
    
    parOut = jsondecode(string(newstr(1)));
        
    err = jsondecode(string(newstr(2)));
    
end

function [err] = ToMatlab(Con, filepath )

    tekst = sprintf ("{ ""Command"":""ToMatlab"" }{""FilePath"":""%s""}", replace(filepath,"\","\\"));
    Frame = ZeroMQ.ZFrame(tekst);
     
    Con.Send(Frame);

    Rec = Con.ReceiveFrame();

    txt = Rec.ReadString();
    
    newstr = split(string(txt),"");

   err = jsondecode(string(newstr(1)));
   
end




