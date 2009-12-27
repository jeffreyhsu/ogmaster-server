# -*- coding: utf-8 -*-
from ogmserver.model.base import *
from ogmserver.model.auth import User

class PlayerRecord(DeclarativeBase):
    __tablename__ = 'stat_player'

    id = Column(Integer, autoincrement=True, primary_key=True)
    player_name = Column(Unicode(50))
    ogameid = Column(Integer, ForeignKey('player.ogameid'))
    rank = Column(Integer)
    points = Column(Integer)
    fleet_rank = Column(Integer)
    fleet_points = Column(Integer)
    research_rank = Column(Integer)
    research_points = Column(Integer)
    ally = Column(Unicode(50))

    updated = Column(DateTime)

class AllianceRecord(DeclarativeBase):
    __tablename__ = 'stat_alliance'

    id = Column(Integer, autoincrement=True, primary_key=True)
    ogameid = Column(Integer, ForeignKey('alliance.ogameid'))
    rank = Column(Integer)
    points = Column(Integer)

    updated = Column(DateTime)