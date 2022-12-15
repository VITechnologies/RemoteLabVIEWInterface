"""
Made By MS
File as example for hello world :)
"""
# Import the LabVIEW exported classes
import labview_functions as lv

#create an class instance for labview control, opening the connection
lvc=lv.LabviewControl("tcp://127.0.0.1:5555")

#try for labview error
try:
    #call a function
    lvc.Console.Print("hello world")
except lv.LabVIEWerror as error:
    print(error)
    