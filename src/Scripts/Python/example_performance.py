"""
Made By MS
File as example for testing performance.
"""
import time
import numpy as np
import matplotlib.pyplot as plt
# Import the LabVIEW exported classes
import labview_functions as lv

lvc=lv.LabviewControl("tcp://127.0.0.1:5555")

# execute the PerformanceTest function for a number of times and time the execution
nptimearray=np.empty(0)
npdataarray=np.arange(0,100,0.1)
lists = npdataarray.tolist()

i=0
while i<1000:
    i +=1
    start = time.perf_counter()*1000
    try:
        #Result = lvc.PerformanceTest.SendDBL(1)
        Result = lvc.PerformanceTest.SendArray(lists)
        #Result = lvc.PerformanceTest.SendComplexCluster({'subcl': {'dbl': [0, 0, 5]}, 'str': ['', '', '', 'htrsd'], 'Array': [{'Boolean': False, 'String': 'htrysd', 'Array 2': []}, {'Boolean': False, 'String': '', 'Array 2': []}, {'Boolean': False, 'String': '', 'Array 2': []}, {'Boolean': True, 'String': '', 'Array 2': [0, 2]}], 'Path': '', 'Ctl Refnum': 'LVObjUnknown->5E500710'})
        #Result = lvc.PerformanceTest.SendVarious(True, [1,2,5,8],{'subcl': {'dbl': [0, 0, 5]}, 'str': ['', '', '', 'htrsd'], 'Array': [{'Boolean': False, 'String': 'htrysd', 'Array 2': []}, {'Boolean': False, 'String': '', 'Array 2': []}, {'Boolean': False, 'String': '', 'Array 2': []}, {'Boolean': True, 'String': '', 'Array 2': [0, 2]}], 'Path': ''})
    except lv.LabVIEWerror as error:
        print(error)
    end = time.perf_counter()*1000
    #print("result: " + str(Result))
    nptimearray = np.append(nptimearray,(end-start))
    #print("single  loop time: " + str(end-start))
Maxtime = np.max(nptimearray)
print("Max   loop time: " + str(Maxtime))
Meantime = np.mean(nptimearray)
print("Mean  loop time: " + str(Meantime))
Mintime = np.min(nptimearray)
print("Min   loop time: " + str(Mintime))
histogram = np.histogram(nptimearray)
plt.hist(nptimearray,50)
plt.title("Histogram with 'auto' bins")
plt.show()
