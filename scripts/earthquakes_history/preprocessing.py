from collections import Counter
import re

class Preprocessing:

    @classmethod
    def cleanHeaders(cls, eq_list_raw):
        eq_list_no_headers = []
        for eq in eq_list_raw:
            if 'time' not in eq:
                eq_list_no_headers.append(eq)
        return eq_list_no_headers

    @classmethod
    def splitDateTime(cls, eq_list_no_headers):
        eq_list_temp = []
        for eq in eq_list_no_headers:
            eq_temp = eq
            eq_str = "".join(eq)
            eq_year = eq_str[0:4]
            eq_temp.insert(0, eq_year)
            eq_month = eq_str[5:7]
            eq_temp.insert(1, eq_month)
            eq_day = eq_str[8:10]
            eq_temp.insert(2, eq_day)
            eq_date = eq_str[0:10]
            eq_temp.insert(3,eq_date)
            eq_time = eq_str[11:19]
            eq_temp.insert(4, eq_time)
            eq_list_temp.append(eq_temp)
        return eq_list_temp

    @classmethod
    def checkCountry(cls, eq_list_temp):
        eq_list = []
        for eq in eq_list_temp:
            counter = Counter(eq[18])
            count = counter[',']
            if count > 1:
                eq[18] = re.sub(",","",eq[18],count = count - 1)
            elif count == 0:
                eq[18] = eq[18] + ","
            eq_list.append(eq)
        return eq_list