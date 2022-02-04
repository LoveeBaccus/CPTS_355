# CptS 355 - Fall 2021 - Assignment 3
# Lovee Baccus

debugging = False
def debug(*s): 
     if debugging: 
          print(*s)

my_cats_log =  {(2,2019):{"Oceanfish":7, "Tuna":1, "Whitefish":3, "Chicken":4, "Beef":2},
                (5,2019):{"Oceanfish":6, "Tuna":2, "Whitefish":1, "Salmon":3, "Chicken":6},
                (9,2019):{"Tuna":3, "Whitefish":3, "Salmon":2, "Chicken":5, "Beef":2, "Turkey":1, "Sardines":1},
                (5,2020):{"Whitefish":5, "Sardines":3, "Chicken":7, "Beef":3},
                (8,2020):{"Oceanfish":3, "Tuna":2, "Whitefish":2, "Salmon":2, "Chicken":4, "Beef":2, "Turkey":1},
                (10,2020):{"Tuna":2, "Whitefish":2, "Salmon":2, "Chicken":4, "Beef":2, "Turkey":4, "Sardines":1},
                (12,2020):{"Chicken":7,"Beef":3, "Turkey":4, "Whitefish":1, "Sardines":2},
                (4,2021):{"Salmon":2,"Whitefish":4, "Turkey":2, "Beef":4, "Tuna":3, "MixedGrill": 2}, 
                (5,2021):{"Tuna":5,"Beef":4, "Scallop":4, "Chicken":3}, 
                (6,2021):{"Turkey":2,"Salmon":2, "Scallop":5, "Oceanfish":5, "Sardines":3}, 
                (9,2021):{"Chicken":8,"Beef":6},                 
                (10,2021):{ "Sardines":1, "Tuna":2, "Whitefish":2, "Salmon":2, "Chicken":4, "Beef":2, "Turkey":4} }

p1a_output = {2019: {'Oceanfish': 13, 'Tuna': 6, 'Whitefish': 7, 'Chicken': 15, 'Beef': 4, 'Salmon': 5, 'Turkey': 1, 'Sardines': 1}, 
              2020: {'Whitefish': 10, 'Sardines': 6, 'Chicken': 22, 'Beef': 10, 'Oceanfish': 3, 'Tuna': 4, 'Salmon': 4, 'Turkey': 9}, 
              2021: {'Salmon': 6, 'Whitefish': 6, 'Turkey': 8, 'Beef': 16, 'Tuna': 10, 'MixedGrill': 2, 'Scallop': 9, 'Chicken': 15, 'Oceanfish': 5, 'Sardines': 4}}


## problem 1(a) merge_by_year - 10%

from functools import reduce

## problem 1(b) merge_year - 15%

## problem 1(c) getmax_of_flavor - 15%

graph = {'A':{'B','C','D'},'B':{'C'},'C':{'B','E','F','G'},'D':{'A','E','F'},'E':{'F'}, 'F':{'E', 'G'},'G':{}, 'H':{'F','G'}}
## problem 2(a) follow_the_follower - 10%

## problem 2(b) follow_the_follower2 - 6%

## problem 3 - connected - 15%

## problem 4(a) - lazy_word_reader - 20%

## problem 4(b) - word_histogram - 3%
