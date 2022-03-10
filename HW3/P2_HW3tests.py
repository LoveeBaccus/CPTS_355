import unittest
from HW3 import *

class P2_HW3tests(unittest.TestCase):
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

    #--- Problem 2----------------------------------
    def test_common_teams(self):
        output = {'UTAH': [(28, 24), (13, 38), (28, 45), (13, 24)], 'ORST': [(56, 37), (54, 53), (38, 28), (31, 24)], 'ORE': [(34, 20), (35, 37), (29, 43), (24, 38)]}
        self.assertDictEqual(common_teams(self.wsu_games),output)


if __name__ == '__main__':
    unittest.main()

