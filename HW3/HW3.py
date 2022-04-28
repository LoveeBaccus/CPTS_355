# CptS 355 - Spring 2022 - Assignment 3 - Python

# Please include your name and the names of the students with whom you discussed any of the problems in this homework
# Name: Lovee Baccus 
# Collaborators: None


debugging = True
def debug(*s): 
     if debugging: 
          print(*s)

wsu_games = {
2018: { "WYO":(41,19), "SJSU":(31,0), "EWU":(59,24), "USC":(36,39), "UTAH":(28,24), 
"ORST":(56,37), "ORE":(34,20), "STAN":(41,38), "CAL":(19,13), "COLO":(31,7), 
"ARIZ":(69,28), "WASH":(15,28), "ISU":(28,26)},
2019: {"NMSU":(58,7), "UNCO":(59,17), "HOU":(31,24), "UCLA":(63,67), "UTAH":(13,38), 
"ASU":(34,38), "COLO":(41,10), "ORE":(35,37), "CAL":(20,33), "STAN":(49,22), 
"ORST":(54,53), "WASH":(13,31), "AFA":(21,31) },
2020: {"ORST":(38,28), "ORE":(29,43), "USC":(13,38), "UTAH":(28,45)},
2021: { "USU":(23,26), "PORT ST.":(44,24), "USC":(14,45), "UTAH":(13,24), "CAL":(21,6),
"ORST":(31,24), "STAN":(34,31), "BYU":(19,21), "ASU":(34,21), "ORE":(24,38), 
"ARIZ":(44,18), "WASH":(40,13), "CMU":(21,24)} }


## problem 1 - all_games - 8%
## rearrange this data and create a dictionary where the keys are the opponent teams and the values are dictionaries of games WSU played against those teams
## EX: 'WYO': {2018: (41, 19)}
## given: wsu_games = { year : games { school : (score1, score2) }
## dictionary w keys of years, and values of another dictionary 
## output: games = { school : { year : (score1, score2) }

def all_games(data):
     d = {}
     for year, game_log in data.items():
          for school, score in game_log.items():
               if school not in d.keys():
                    d[school] = {}
               d[school][year] = score
     return d

##debug(all_games(wsu_games))

from functools import reduce
## problem 2 - common_teams - 15%
## we can call all_games, and then say if each school has all the years, add it to the output dict
## i think we just want to repeat the same steps as all_games, to get the right format and then call reduce at the end
## we can use reduce to get rid of all the items that dont have 4 games recorded? 
## reduce is frustrating so I just did an if statement with a for loop 

## want output in the form: School : [sore]

def common_teams(data):
     d = {}
     for year, game_log in data.items():
          for school, score in game_log.items():
               if school not in d.keys():
                    d[school] = []
               d[school].append(score)

     d1 = {}
     for school, score_log in d.items():
          if len(score_log) == 4:
               d1[school] = score_log
     return d1

debug(common_teams(wsu_games))
## problem 3 - get_wins - 16%

## problem 4 - wins_by_year - 16%

## problem 5 - longest_path - 16% 

## problem 6 - counter - 20% 