from datetime import datetime, timedelta
import sys

for line in sys.stdin:
       y_m_d, code, id  = line.split('\t')
       print code
       print y_m_d
       start_date = datetime.strptime(y_m_d, "%Y-%m-%d")
       end_date = start_date + timedelta(1)
       seismograph = "http://service.iris.edu/irisws/timeseries/1/query?net=IU&sta={}&loc=00&cha=BHZ&starttime=2005-01-01T00:00:00&endtime=2005-01-02T00:00:00&output=plot".format(code, start_date.strftime("%Y-%m-%dZ%H:%M:%S"), end_date.strftime("%Y-%m-%dZ%H:%M:%S"))
       print(seismograph)
