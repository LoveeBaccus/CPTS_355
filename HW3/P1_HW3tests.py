import unittest
from HW3 import *

class P1_HW3tests(unittest.TestCase):
    "Unittest setup file. Unittest framework will run this before every test."
    def setUp(self):
        self.wsu_games = {
            2018: { "WYO":(41,19), "SJSU":(31,0),  "EWU":(59,24), "USC":(36,39), "UTAH":(28,24), 
                   "ORST":(56,37), "ORE":(34,20), "STAN":(41,38), "CAL":(19,13), "COLO":(31,7), 
                   "ARIZ":(69,28), "WASH":(15,28), "ISU":(28,26)},
            2019: {"NMSU":(58,7), "UNCO":(59,17), "HOU":(31,24), "UCLA":(63,67), "UTAH":(13,38), 
                    "ASU":(34,38), "COLO":(41,10), "ORE":(35,37), "CAL":(20,33), "STAN":(49,22), 
                   "ORST":(54,53), "WASH":(13,31), "AFA":(21,31) },
            2020: {"ORST":(38,28), "ORE":(29,43), "USC":(13,38), "UTAH":(28,45)},
            2021: { "USU":(23,26), "PORT ST.":(44,24), "USC":(14,45), "UTAH":(13,24), "CAL":(21,6),
                   "ORST":(31,24), "STAN":(34,31), "BYU":(19,21), "ASU":(34,21), "ORE":(24,38), 
                   "ARIZ":(44,18), "WASH":(40,13), "CMU":(21,24)} }
     
    #--- Problem 1----------------------------------
    def test_all_games(self):
        output = {'WYO': {2018: (41, 19)}, 
                 'SJSU': {2018: (31, 0)}, 
                  'EWU': {2018: (59, 24)}, 
                  'USC': {2018: (36, 39), 2020: (13, 38), 2021: (14, 45)}, 
                 'UTAH': {2018: (28, 24), 2019: (13, 38), 2020: (28, 45), 2021: (13, 24)}, 
                 'ORST': {2018: (56, 37), 2019: (54, 53), 2020: (38, 28), 2021: (31, 24)}, 
                  'ORE': {2018: (34, 20), 2019: (35, 37), 2020: (29, 43), 2021: (24, 38)}, 
                 'STAN': {2018: (41, 38), 2019: (49, 22), 2021: (34, 31)}, 
                  'CAL': {2018: (19, 13), 2019: (20, 33), 2021: (21, 6)}, 
                 'COLO': {2018: (31, 7), 2019: (41, 10)}, 
                 'ARIZ': {2018: (69, 28), 2021: (44, 18)}, 
                 'WASH': {2018: (15, 28), 2019: (13, 31), 2021: (40, 13)}, 
                  'ISU': {2018: (28, 26)}, 
                 'NMSU': {2019: (58, 7)}, 
                 'UNCO': {2019: (59, 17)}, 
                  'HOU': {2019: (31, 24)}, 
                 'UCLA': {2019: (63, 67)}, 
                  'ASU': {2019: (34, 38), 2021: (34, 21)}, 
                  'AFA': {2019: (21, 31)}, 
                  'USU': {2021: (23, 26)}, 
             'PORT ST.': {2021: (44, 24)}, 
                  'BYU': {2021: (19, 21)}, 
                  'CMU': {2021: (21, 24)} }

        self.assertDictEqual(all_games(self.wsu_games),output)
    
if __name__ == '__main__':
    unittest.main()

