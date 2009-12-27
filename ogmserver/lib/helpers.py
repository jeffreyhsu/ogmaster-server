# -*- coding: utf-8 -*-

"""WebHelpers used in ogmserver."""

from webhelpers import date, feedgenerator, html, number, misc, text

from ogmserver.model import DBSession

from webhelpers import paginate as p

import md5, random, time

class Enum(object):
    @classmethod
    def toStr(self, type):
        return [i for i in self.__dict__ if getattr(self, i) == type][0]

def random_str(length=None, *seed):
    s = md5.new(str(random.random()) + str(time.time()) + ''.join(seed)).hexdigest()
    if length:
        return ''.join(random.sample(s, length))
    return s

class paginate(object):
    def __init__(self, * collections):
        self.collections = collections

    def __call__(self, f):
        """
        If there are decorator arguments, __call__() is only called
        once, as part of the decoration process! You can only give
        it a single argument, which is the function object.
        """
#        from ogmserver.lib import paginate as p
        def wrapped_f(*args, ** kw):
            d = f(*args, ** kw)
            for item in self.collections:
                size = 15
                if isinstance(item, list):
                    c = item[0]
                    size = item[1]
                else:
                    c = item
                page = p.Page(d[c], int(kw.get("page", 1)), items_per_page=size)
                d[c] = page
            return d
        return wrapped_f