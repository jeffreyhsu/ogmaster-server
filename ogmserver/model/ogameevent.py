# -*- coding: utf-8 -*-
from ogmserver.model.base import *
from ogmserver.model.auth import User
from ogmserver.model.planet import Planet
from ogmserver.model.player import Player

class OgameEvent(DeclarativeBase):
    __tablename__ = 'ogame_event'

    id = Column(Integer, autoincrement=True, primary_key=True)

    type = Column(String(20))
    data = Column(String(20))

    owner_planet_id = Column(Integer, ForeignKey('planet.id'))
    owner_id = Column(Integer, ForeignKey('player.ogameid'))

    target_planet_id = Column(Integer, ForeignKey('planet.id'))
    target_id = Column(Integer, ForeignKey('player.ogameid'))

    online_index = Column(Integer, default=1)

    owner_planet = relation(Planet, primaryjoin=owner_planet_id==Planet.id, backref=backref('events', lazy='dynamic'))
    owner = relation(Player, primaryjoin=owner_id==Player.ogameid, backref=backref('events', lazy='dynamic'))

    target_planet = relation(Planet, primaryjoin=target_planet_id==Planet.id, backref=backref('target_events', lazy='dynamic'))
    target = relation(Player, primaryjoin=target_id==Player.ogameid, backref=backref('target_events', lazy='dynamic'))

    updated = Column(DateTime)