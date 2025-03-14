from sqlalchemy import Column, Integer, String, Text, ForeignKey, Time, DateTime
from sqlalchemy.orm import relationship, declarative_base
from ..db.db import Base

Base = declarative_base()

class Match(Base):
    __tablename__ = "Match"

    idMatch = Column(Integer, primary_key=True, index=True)
    Championship = Column(String(45), nullable=False)
    Stage = Column(String(45), nullable=False)
    Score = Column(Integer, nullable=False)
    Date = Column(DateTime, nullable=False)
    Place = Column(String(45), nullable=False)
    Description = Column(Text, nullable=False)
    Image = Column(String(255), nullable=False)


class User(Base):
    __tablename__ = 'User'

    idUser = Column(Integer, primary_key=True, autoincrement=True)
    FirstName = Column(String(200), nullable=False)
    LastName = Column(String(45), nullable=False)

    idTeam = Column(Integer, ForeignKey('Team.idTeam'), nullable=True)

    # Relations
    players = relationship("Player", back_populates="user", cascade="all, delete-orphan")


class Statistics(Base):
    __tablename__ = 'Statistics'

    idStat = Column(Integer, primary_key=True, autoincrement=True)
    Rebounds = Column(Integer, nullable=False)
    Points = Column(Integer, nullable=False)
    ThreePtsFieldGoalsMade = Column(Integer, nullable=True)
    ThreePtsFieldGoalsAttempted = Column(Integer, nullable=True)
    FreeThrowMade = Column(Integer, nullable=False)
    FreeThrowAttempted = Column(Integer, nullable=False)

    players = relationship("Player", back_populates="statistic")


class Team(Base):
    __tablename__ = "Team"

    idTeam = Column(Integer, primary_key=True, autoincrement=True)
    Name = Column(String(45), nullable=False)
    NbPlayers = Column(String(45), nullable=False)
    TrainingDates = Column(Text, nullable=False)
    TrainingPlace = Column(String(45), nullable=False)
    RegistrationFee = Column(Text, nullable=False)

    trainings = relationship("Training", back_populates="team")

class Player(Base):
    __tablename__ = 'Player'
    
    idUser = Column(Integer, ForeignKey('User.idUser'), primary_key=True)
    idStat = Column(Integer, ForeignKey('Statistics.idStat'), nullable=True)

    # Relations
    user = relationship("User", back_populates="players")
    statistic = relationship("Statistics", back_populates="players")


class Admin(Base): 
    __tablename__ = 'Admin' 
    idAdmin = Column(Integer, ForeignKey('User.idUser'), primary_key=True) 
    login = Column(String(45), nullable=False) 
    password = Column(String(45), nullable=False)

class Training(Base): 
    __tablename__ = 'Training' 
    idTraining = Column(Integer, primary_key=True, autoincrement=True) 
    WeekDay = Column(Integer, nullable=False) 
    StartHour = Column(Time, nullable=False)
    EndHour = Column(Time, nullable=False)
    Place = Column(String(255), nullable=False)
    idTeam = Column(Integer,  ForeignKey('Team.idTeam'), nullable=False)

     # Relations
    team = relationship("Team", back_populates="trainings")
