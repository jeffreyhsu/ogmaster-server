# -*- coding: utf-8 -*-

import re

from ogmserver.lib.helpers import *

class Point(object):
    def __init__(self, x, y):
        self.x = x
        self.y = y
    def __composite_values__(self):
        return [self.x, self.y]
    def __set_composite_values__(self, x, y):
        self.x = x
        self.y = y
    def __eq__(self, other):
        return other.x == self.x and other.y == self.y
    def __ne__(self, other):
        return not self.__eq__(other) 


class Coord(object):
    """Coordinate object

    >>> Coord('2:382:9')
    [2:382:9]
    >>> Coord('2:382')
    [2:382:0]
    >>> c = Coord(4,109,6)
    >>> c
    [4:109:6]
    >>> c.tuple()
    (4, 109, 6)
    >>> c.type
    1
    >>> c1 = Coord(2,169,5)
    >>> c2 = Coord(2,169,10)
    >>> c1.distance_to(c2)
    1025
    """

    class Types(Enum):
        unknown = 0
        planet  = 1
        debris  = 2
        moon = 3

    PLANETS_PER_SYSTEM = 15
    REGEXP_coord    = re.compile(r"([0-9]{1,3}):([0-9]{1,3}):?([0-9]{1,2})?")

    def __init__(self, galaxy, system=0, position=0, type=Types.planet):
        '''
            First parameter can be a string to be parsed e.g: [1:259:12] or the galaxy.
            If it's the galaxy, system and planet must also be supplied.
        '''
        self.type = type
        try: 
            self.parse(galaxy)
        except Exception:
            self.galaxy = galaxy
            self.system = system
            self.position = position
            self.convert_to_ints()

    def is_moon(self):
        return self.type == self.Types.moon

    def parse(self, newcoord):
        match = self.REGEXP_coord.search(newcoord)
        if not match:
            raise Exception("Error parsing coord: " + newcoord)
        self.galaxy, self.system, self.position = match.groups()
        self.position = self.position if self.position else 0
        if 'moon' in newcoord: self.type = self.Types.moon
        self.convert_to_ints()

    def tuple(self):
        return self.galaxy, self.system, self.position

    def convert_to_ints(self):
        self.galaxy, self.system, self.position = int(self.galaxy), int(self.system), int(self.position)

    def to_string(self):
        return "%s:%s:%s" % (self.galaxy, self.system, self.position)

    def __repr__(self):
        repr = "[%s:%s:%s]" % (self.galaxy, self.system, self.position)
        if not self.type == self.Types.planet:
            repr += " " + self.Types.toStr(self.type)
        return  repr

    def __eq__(self, othercoord):
        return self.tuple() == othercoord.tuple() and self.type == othercoord.type

    def __ne__(self, othercoord):
        return not self.__eq__(othercoord)

    def __lt__(self,othercoord):
        if self.galaxy < othercoord.galaxy:
            return True
        elif self.galaxy == othercoord.galaxy:
            if self.system < othercoord.system:
                return True
            elif self.system == othercoord.system:
                if self.position < othercoord.position:
                    return True
        return False

    def distance_to(self, coord):

        distance = 0
        if   coord.galaxy - self.galaxy != 0:
            distance = abs(coord.galaxy - self.galaxy) * 20000
        elif coord.system - self.system != 0:
            distance = abs(coord.system - self.system) * 5 * 19 + 2700
        elif coord.position - self.position != 0:
            distance = abs(coord.position - self.position) * 5 + 1000
        else:
            distance = 5
        return distance

    def flightTimeTo(self, coord, speed, speedPercentage=100):
        seconds = 350000.0/speedPercentage * math.sqrt(self.distanceTo(coord) * 10.0 / float(speed)) + 10.0
        return datetime.timedelta(seconds=int(seconds))


    def __composite_values__(self):
        return [self.galaxy, self.system, self.position]

    def __set_composite_values__(self, galaxy, system, position):
        self.galaxy = galaxy
        self.system = system
        self.position = position