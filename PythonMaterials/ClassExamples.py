#CptS 355 class examples
debugging = True
def debug(*s): 
    if debugging: 
        print(*s)

# histogram
def histo(s):
    d = {}
    for c in s:
        if c in d.keys():
            d[c] = d[c] + 1
        else: # we see the character c for the first time
            d[c] = 1
    return sorted(list(d.items()))

def histo(s):
    d = {}
    for c in s:
        d[c] = d.get(c,0) + 1
    return sorted(sorted(list(d.items())), key = lambda item: item[1],reverse=True)

def histo2(s):
    return list(set([(c,s.count(c)) for c in s]))

# Expected output for histo("implemented")
[('e', 3), ('m', 2), ('d', 1), ('i', 1), ('l', 1), ('n', 1), ('p', 1), ('t', 1)]

#------------------------------------------------------------------------------------

#sumSales

mysales = {'Amazon':{'Mon':30,'Wed':100,'Sat':200}, 
           'Etsy':{'Mon':50,'Tue':20,'Wed':25,'Fri':30}, 
           'Ebay':{'Tue':60,'Wed':100,'Thu':30}, 
           'Shopify':{'Tue':100,'Thu':50,'Sat':20}}

output = {'Fri': 30, 'Mon': 80, 'Sat': 220, 'Thu': 80, 'Tue': 180, 'Wed': 225}
{'Mon': 80, 'Wed': 225, 'Sat': 220, 'Tue': 180, 'Fri': 30, 'Thu': 80}

#(a)
def sumSales(sales):
   d = {}
   # iterate over store,log pairs
   for log in sales.values():
      #iterate over day,sale pairs
      for day,sale in log.items():
         #add sale to day's total sale in d
         d[day] = d.get(day,0) + sale 
   return dict(sorted(list(d.items())))
   # sort and return d 

#(b) sumSalesN
allSales = [{'Amazon':{'Mon':30,'Wed':100,'Sat':200},'Etsy':{'Mon':50,'Tue':20,'Wed':25,'Fri':30},'Ebay':{'Tue':60,'Wed':100,'Thu':30},'Shopify':{'Tue':100,'Thu':50,'Sat':20}},
            {'Shopify':{'Mon':25},'Etsy':{'Thu':40, 'Fri':50}, 'Ebay':{'Mon':100,'Sat':30}},
            {'Amazon':{'Sun':88},'Etsy':{'Fri':55},'Ebay':{'Mon':40},'Shopify':{'Sat':35}}]

#expected output
{'Fri': 135,'Mon':245,'Sat':285,'Sun': 88,'Thu': 120,'Tue':180,'Wed':225}



#step1 - sum all sales logs
[{'Fri': 30, 'Mon': 80, 'Sat': 220, 'Thu': 80, 'Tue': 180, 'Wed': 225}, {'Fri': 50, 'Mon': 125, 'Sat': 30, 'Thu': 40}, {'Fri': 55, 'Mon': 40, 'Sat': 35, 'Sun': 88}]

# step2 - combine salelogs, sum sles for same dayas of the week
{'Fri': 135, 'Mon': 245, 'Sat': 285, 'Sun': 88, 'Thu': 120, 'Tue': 180, 'Wed': 225}

import copy
from functools import reduce

def sumSalesN (L):
    def combine_dicts_ho (d1,d2):
        d = copy.deepcopy(d1)
        _common_items = map(lambda x: (x[0],x[1]+d2.get(x[0],0)), d.items())
        _other_items = filter(lambda x: x[0] not in d1.keys(), d2.items())
        return dict(list(_common_items) + list(_other_items))
    return dict(sorted(list(reduce(combine_dicts_ho, list(map(sumSales,L))).items())))




if __name__ == "__main__":
    debug("histogram-test1",histo("implemented"))
    debug("histogram-test2",histo("ABBCCCDDDDEEEEEFFFFFFGGGGGGG"))
    debug("sumSales-test1",sumSales(mysales))



