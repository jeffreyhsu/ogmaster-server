# -*- coding: utf-8 -*-
from ogmserver.model.base import *
from ogmserver.model.auth import User
from ogmserver.model.player import Player
from ogmserver.model.common import Coord

class Planet(DeclarativeBase):
    __tablename__ = 'planet'

    id = Column(Integer, primary_key=True, autoincrement=True)

    name = Column(Unicode(20))
    _prev_names = Column(String(200), default='[]')

    galaxy = Column(Integer)
    system = Column(Integer)
    position = Column(Integer)
    _coord = Column(Unicode(20))

    def _get_coord(self):
        return Coord(self.galaxy, self.system, self.position)

    def _set_coord(self, value):
        self.galaxy = value.galaxy
        self.system = value.system
        self.position = value.position
        self._coord = value.to_string()

    coord = synonym('_coords', descriptor=property(_get_coord, _set_coord))

    has_moon = Column(Boolean, default=False)
    debris_amount = Column(Integer)
    debris_metal = Column(Integer)
    debris_crystal = Column(Integer)

    _player_status = Column(String(20))

    status = Column(String(20))

    player_name = Column(Unicode(20))
    player_id = Column(Integer, ForeignKey('player.ogameid'))

    def _get_prev_names(self):
        return eval(self._prev_names)

    def _set_prev_names(self, value):
        self._prev_names = repr(value)

    prev_names = synonym('_prev_names', descriptor=property(_get_prev_names,
                                                        _set_prev_names))
    def _get_player_status(self):
        return eval(self._status)

    def _set_player_status(self, status):
        self._status = repr(status)

    player_status = synonym('_player_status', descriptor=property(_get_player_status, _set_player_status))

    updated = Column(DateTime)

    player = relation(Player, backref=backref('planets', lazy='dynamic'))

    def can_attack(self):
        status = self.player_status
        s = set(['v', 'n', 's'])
        return not bool(s & status)