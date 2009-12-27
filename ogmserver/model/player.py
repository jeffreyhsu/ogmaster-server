# -*- coding: utf-8 -*-
from ogmserver.model.base import *
from ogmserver.model.auth import User
from ogmserver.model.alliance import Alliance

class Player(DeclarativeBase):
    __tablename__ = 'player'

    ogameid = Column(Integer, autoincrement=False, primary_key=True)
    name = Column(Unicode(20))

    rank = Column(Integer)
    points = Column(Integer)

    _prev_names = Column(Unicode(200), default='[]')

    alliance_id = Column(Integer, ForeignKey('alliance.ogameid'))

    alliance = relation(Alliance, backref=backref('players', lazy='dynamic'))

    _status = Column(String(20))

    def _get_status(self):
        return eval(self._status)

    def _set_status(self, status):
        self._status = repr(status)

    status = synonym('_status', descriptor=property(_get_status,
                                                        _set_status))

    def _get_prev_names(self):
        return eval(self._prev_names)

    def _set_prev_names(self, value):
        self._prev_names = repr(value)

    prev_names = synonym('_prev_names', descriptor=property(_get_prev_names,
                                                        _set_prev_names))

    def can_attack(self):
        return not bool(set(['v', 'n', 's']) & self.status)

    def is_normal(self):
        return not bool(self.status)
    def is_inactive(self):
        return 'i' in self.status or 'I' in self.status
    def is_noob(self):
        return 'n' in self.status
    def is_strong(self):
        return 's' in self.status
    def is_banned(self):
        return 'b' in self.status

    updated = Column(DateTime)