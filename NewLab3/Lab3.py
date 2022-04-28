# CptS 355 - Fall 2021 - Lab 3
# Lovee Baccus

debugging = False
def debug(*s): 
     if debugging: 
          print(*s)


CDCdata = {'King':{'Mar':2706,'Apr':3620,'May':1860,'Jun':2157,'July':5014,'Aug':4327,'Sep':2843},
        'Pierce':{'Mar':460,'Apr':965,'May':522,'Jun':647,'July':2470,'Aug':1776,'Sep':1266},
         'Snohomish':{'Mar':1301,'Apr':1145,'May':532,'Jun':568,'July':1540,'Aug':1134,'Sep':811},
         'Spokane':{'Mar':147,'Apr':222,'May':233,'Jun':794,'July':2412,'Aug':1530,'Sep':1751},
         'Whitman' : {'Apr':7,'May':5,'Jun':19,'July':51,'Aug':514,'Sep':732, 'Oct':278} }

monthlyCases = {'Mar':{'King':2706,'Pierce':460,'Snohomish':1301,'Spokane':147},
              'Apr':{'King':3620,'Pierce':965,'Snohomish':1145,'Spokane':222,'Whitman':7},
              'May':{'King':1860,'Pierce':522,'Snohomish':532,'Spokane':233,'Whitman':5},
              'Jun':{'King':2157,'Pierce':647,'Snohomish':568,'Spokane':794,'Whitman':19},
              'July':{'King':5014,'Pierce':2470,'Snohomish':1540,'Spokane':2412,'Whitman':51},
              'Aug':{'King':4327,'Pierce':1776,'Snohomish':1134,'Spokane':1530,'Whitman':514},
              'Sep':{'King':2843,'Pierce':1266,'Snohomish':811,'Spokane':1751,'Whitman':732},
              'Oct':{'Whitman':278}}


## problem 1 getNumCases 
def getNumCases(data,counties,months):
    sum = 0
    for county in counties:
         for month in months:
              sum+= data[county][month]
    return sum


debug(getNumCases(CDCdata, ['Whitman'],['Apr','May','Jun']))
debug(getNumCases(CDCdata, ['King', 'Pierce'], ['July', 'Aug']))

## problem 2 getMonthlyCases
def getMonthlyCases(data):
    d = {}
    for county, log in data.items():
        for month, number in log.items():
            if month not in d.keys():
                d[month] = {}
            d[month][county] = number
                # add county and month to the month's log
    return d

debug(getMonthlyCases(CDCdata))

from functools import reduce
## problem 3 mostCases 
#1
log = {'Mar':2706,'Apr':3620,'May':1860,'Jun':2157,'July':5014,'Aug':4327,'Sep':2843}
from functools import reduce
sum_log = lambda log: reduce(lambda x,y: x+y, log.values())

#2
tlog = ('King', {'Mar':2706,'Apr':3620,'May':1860,'Jun':2157,'July':5014,'Aug':4327,'Sep':2843})
('King', 22527)
helper = (lambda tlog: (tlog[0], sum_log(tlog[1])))
map( lambda tlog: (tlog[0], sum_log(tlog[1])), monthlyCases.items() )

#3
alltuples = [('Mar', 4614), ('Apr', 5959), ('May', 3152), ('Jun', 4185), ('July', 11487), ('Aug', 9281), ('Sep', 7403), ('Oct', 278)]
helper = lambda x,y : x if x[1] > y[1] else y
helper(('Mar', 4614), ('Apr', 5959))
reduce(helper, alltuples)

from functools import reduce

def mostCases(data):
    monthlyCases = getMonthlyCases(data)
    sum_log = lambda log: reduce(lambda x,y: x+y, log.values())
    alltuples = map(lambda tlog: (tlog[0], sum_log(tlog[1])), monthlyCases.items() )
    return reduce(lambda x,y : x if x[1] > y[1] else y, alltuples)

## problem 4a) searchDicts(L,k)
## problem 4b) searchDicts2(L,k)

## problem 5 - getLongest
def getLongest(l1):
    getLonger = lambda x,y: x if len(x)>len(y) else y
    longest = ''
    for item in l1:
        if type(item) == list:
            longest = getLonger(getLongest(item), longest)
        else:
            longest = getLonger(item, longest)
    return longest
## problem 6 - apply2nextN 