# -*- coding: utf-8 -*-
from ogmserver.model.base import *
from ogmserver.model.auth import User

class Alliance(DeclarativeBase):
    __tablename__ = 'alliance'

    ogameid = Column(Integer, autoincrement=False, primary_key=True)
    name = Column(Unicode(20))
    fullname = Column(Unicode(100))
    _prev_names = Column(Unicode(200), default='[]')

    def _get_prev_names(self):
        return eval(self._prev_names)

    def _set_prev_names(self, value):
        self._prev_names = repr(value)

    prev_names = synonym('_prev_names', descriptor=property(_get_prev_names,
                                                        _set_prev_names))
    rank = Column(Integer)

    updated = Column(DateTime)