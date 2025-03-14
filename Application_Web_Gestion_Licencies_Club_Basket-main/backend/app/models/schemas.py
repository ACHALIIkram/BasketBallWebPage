from pydantic import BaseModel
from datetime import date, time, datetime
from typing import Optional, List

#######
# User
#######

class UserBase(BaseModel):
    FirstName: str
    LastName: str
    idTeam: Optional[int] = None

class UserCreate(UserBase):
    pass

class User(UserBase):
    idUser: int

    class Config:
        orm_mode = True


#######
# Match
#######

class MatchBase(BaseModel):
    Championship: str
    Stage: str
    Score: int
    Date: datetime
    Place: str
    Description : str
    Image : str


class MatchCreate(MatchBase):
    pass

class Match(MatchBase):
    idMatch: int

    class Config:
        orm_mode = True


#######
# Team
#######

class TeamBase(BaseModel):
    Name: str
    NbPlayers: str
    TrainingDates: str
    TrainingPlace: str
    RegistrationFee: str

class TeamWithUsers(TeamBase):
    users: List[UserBase]

class TeamCreate(TeamBase):
    pass

class TeamUpdate(BaseModel):
    Name: Optional[str]
    NbPlayers: Optional[str]
    TrainingDates: Optional[str]
    TrainingPlace: Optional[str]
    RegistrationFee: Optional[str]

class Team(TeamBase):
    idTeam: int

    class Config:
        orm_mode = True


#############
# Statistics
#############

class StatisticsBase(BaseModel):
    Rebounds: int
    Points: int
    ThreePtsFieldGoalsMade: Optional[int] = None
    ThreePtsFieldGoalsAttempted: Optional[int] = None
    FreeThrowMade: int
    FreeThrowAttempted: int

class StatisticsCreate(StatisticsBase):
    pass

class StatisticsUpdate(StatisticsBase):
    pass

class Statistics(StatisticsBase):
    idStat: int

    class Config:
        orm_mode = True


#######
# Player
#######

class UserOut(BaseModel):
    FirstName: str
    LastName: str

    class Config:
        orm_mode = True

class StatisticOut(BaseModel):
    Rebounds: int
    Points: int
    ThreePtsFieldGoalsMade: Optional[int]
    ThreePtsFieldGoalsAttempted: Optional[int]
    FreeThrowMade: int
    FreeThrowAttempted: int

    class Config:
        orm_mode = True

class PlayerOut(BaseModel):
    idUser: int
    user: UserOut
    statistic: StatisticOut

    class Config:
        orm_mode = True


class PlayerCreate(BaseModel):
    user: UserCreate
    statistic: StatisticsCreate
    

#######
# Login
#######

class LoginRequest(BaseModel):
    login: str
    password: str

#######
# Training
#######

class TrainingBase(BaseModel):
    WeekDay: int
    StartHour: time
    EndHour : time
    Place : str
    idTeam: Optional[int] = None

class TrainingCreate(TrainingBase):
    pass

class Training(TrainingBase):
    idTraining: int

    class Config:
        orm_mode = True

class TrainingUpdate(BaseModel):
    WeekDay: Optional[int]
    StartHour: Optional[time]
    EndHour: Optional[time]
    Place: Optional[str]
    idTeam: Optional[int]
