import json
import zmq

class RemoteCall:
    """Class for connecting and executing commands over ZeroMQ Using JSON
    """
    socket = 0

    def connect(self,connection_string):
        """ Make the initial connection to the client running in LabVIEW

        Parameters
        ----------
        connection_string : String (Example "tcp://127.0.0.1:5555", "ConnectionType"://"IPAdress":"Port")
        """

        context = zmq.Context()
        self.socket = context.socket(zmq.REQ)
        self.socket.connect(connection_string)

    def execute(self, class_name, method, par_in):
        """ Execute the Method by serializing inputs sending it over, and deserializing the result
        """
        data_2_send = "{ \"Command\":\"Execute\" }\x17{\"ClassLabel\":\"%s\",\"Method\":\"%s\"}\x17%s" % (class_name, method, json.dumps({"In": par_in}))
        self.socket.send_string (data_2_send)
        message = self.socket.recv()
        parts = message.split(chr(0x17).encode())
        return json.loads(parts[1]), json.loads(parts[0])

class LabVIEWerror(Exception):
    """Base class for all LabVIEW errors

    Attributes
    ----------
    code: error code for testing which error happend
    source: source of the error
    """
    def __init__(self, *args: object) -> None:
        self.code = self.args[0]
        self.source = self.args[1]
        super().__init__(*args)

    def __str__(self) -> str:
        return f"LabVIEW Error with code: {self.code} source: {self.source}"

class LabviewControl:
    """ Class for calling all labview function with connection embedded
    """

    def __init__(self,connection_string) -> None:
        self._connection=RemoteCall()
        self._connection.connect(connection_string)
        self.Console=Console(self._connection)
        self.PerformanceTest=PerformanceTest(self._connection)

class Console:
    """Class for running a small console in labview with a display showing printed lines
    """
    def __init__(self, con) -> None:
        self._connection=con

    def Clear (self):
        """Clear the console of all lines

        Parameters
        ----------

        Returns
        ----------

        """

        par_in = {
        }

        err, par_out = self._connection.execute("Console", "Clear", par_in)
        if err["status"]:
            raise LabVIEWerror(err["code"],err["source"])

    def GetLines (self):
        """Get all the lines currently on the console

        Parameters
        ----------

        Returns
        ----------
        Lines : String

        """

        par_in = {
        }

        err, par_out = self._connection.execute("Console", "GetLines", par_in)
        if err["status"]:
            raise LabVIEWerror(err["code"],err["source"])
        return par_out["Lines"]

    def Print (self, Line):
        """Print a line to the console

        Parameters
        ----------
        Line : String

        Returns
        ----------

        """

        par_in = {
        "Line" : Line
        }

        err, par_out = self._connection.execute("Console", "Print", par_in)
        if err["status"]:
            raise LabVIEWerror(err["code"],err["source"])

class PerformanceTest:
    """Class for testing timing, data types and performance of sending data between LabVIEW and the calling language
    """
    def __init__(self, con) -> None:
        self._connection=con

    def SendArray (self, In):
        """

        Parameters
        ----------
        In : List [Float]

        Returns
        ----------
        Out : List [Float]

        """

        par_in = {
        "In" : In
        }

        err, par_out = self._connection.execute("PerformanceTest", "SendArray", par_in)
        if err["status"]:
            raise LabVIEWerror(err["code"],err["source"])
        return par_out["Out"]

    def SendComplexCluster (self, In):
        """

        Parameters
        ----------
        In : Dict {"subcl" : Dict {"dbl" : List [Float]}, "str" : List [String], "Array" : List [Dict {"Boolean" : Bool, "String" : String, "Array 2" : List [Float]}], "Path" : Unsupported datatype Path}

        Returns
        ----------
        Out : Dict {"subcl" : Dict {"dbl" : List [Float]}, "str" : List [String], "Array" : List [Dict {"Boolean" : Bool, "String" : String, "Array 2" : List [Float]}], "Path" : Unsupported datatype Path}

        """

        par_in = {
        "In" : In
        }

        err, par_out = self._connection.execute("PerformanceTest", "SendComplexCluster", par_in)
        if err["status"]:
            raise LabVIEWerror(err["code"],err["source"])
        return par_out["Out"]

    def SendDBL (self, In):
        """

        Parameters
        ----------
        In : Float, Control for sending a double

        Returns
        ----------
        Out : Float, Indicator for value filled by the control at the input. Data should be the same.

        """

        par_in = {
        "In" : In
        }

        err, par_out = self._connection.execute("PerformanceTest", "SendDBL", par_in)
        if err["status"]:
            raise LabVIEWerror(err["code"],err["source"])
        return par_out["Out"]

    def SendVarious (self, Boolean_In, Array_in, Cluster_In):
        """

        Parameters
        ----------
        Boolean_In : Bool,
        Array_in : List [Int],
        Cluster_In : Dict {"subcl" : Dict {"dbl" : List [Float]}, "str" : List [String], "Array" : List [Dict {"Boolean" : Bool, "String" : String, "Array 2" : List [Float]}], "Path" : Unsupported datatype Path}

        Returns
        ----------
        Array_Out : List [Int],
        Cluster_Out : Dict {"subcl" : Dict {"dbl" : List [Float]}, "str" : List [String], "Array" : List [Dict {"Boolean" : Bool, "String" : String, "Array 2" : List [Float]}], "Path" : Unsupported datatype Path},
        Boolean_Out : Bool

        """

        par_in = {
        "Boolean_In" : Boolean_In,
        "Array_in" : Array_in,
        "Cluster_In" : Cluster_In
        }

        err, par_out = self._connection.execute("PerformanceTest", "SendVarious", par_in)
        if err["status"]:
            raise LabVIEWerror(err["code"],err["source"])
        return par_out

