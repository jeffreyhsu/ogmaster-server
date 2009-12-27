# -*- coding: utf-8 -*-
"""Sample controller with all its actions protected."""
from tg import expose, flash, redirect, validate
from sqlalchemy.sql import select, text as sqltext
from pylons.i18n import ugettext as _, lazy_ugettext as l_
from repoze.what.predicates import has_permission
#from dbsprockets.dbmechanic.frameworks.tg2 import DBMechanic
#from dbsprockets.saprovider import SAProvider
from formencode import validators
from tw.forms import validators as v

from ogmserver.lib.base import BaseController
from ogmserver.model import *
from ogmserver.lib.helpers import *
from webhelpers import paginate as p
class HunterController(BaseController):

    @expose('ogmserver.templates.hunter.index')
    def index(self, **kw):
        redirect('/hunter/search', hours=6, rank_start=1, rank_end=4000)
        
    @expose('ogmserver.templates.hunter.index')
    @paginate(['result', 100])
    def search(self, **kw):
        hours = kw['hours']
        rank_start = kw['rank_start']
        rank_end = kw['rank_end']

        n = random_str(12, '%s%s%s' % (hours,rank_start,rank_end))
        
        q = """
            select stat.ogameid, stat.rank, stat.points, stat.player_name, max(stat.updated) as updated, stat.ally from stat_player as stat
                where timestampdiff(HOUR, stat.updated, (select stat2.updated from stat_player stat2 order by stat2.id desc limit 1)) <= %s
                and stat.rank between %s and %s
                group by stat.ogameid having min(stat.points) = max(stat.points)
                order by stat.rank
        """ % (hours, rank_start if rank_start else 1, rank_end if rank_end else 99999)
        
        DBSession.execute("create temporary table stat_player_tmp_%s as %s" % (n,q))
        
        if kw.get('galaxy') and kw.get('system'):
            distance = int(kw['distance'])
            q = """
                select tmp.*, planet._coord, abs(planet.system - %s) as d, player._status from planet inner join stat_player_tmp_%s tmp on tmp.ogameid = planet.player_id inner join player on player.ogameid = tmp.ogameid
                    where planet.galaxy = %s and planet.system between %s and %s
                    order by d
            """ % (kw['system'], n, kw['galaxy'], int(kw['system']) - distance, int(kw['system']) + distance)
        else:
            q = "select tmp.*, player._status from stat_player_tmp_%s tmp inner join player on player.ogameid=tmp.ogameid" % n
        
        result = DBSession.execute(q).fetchall()

        DBSession.execute("drop table if exists stat_player_tmp_%s;" % n)

        return dict(_page='hunter>search>novacation', result=result, params=kw)

    @expose('ogmserver.templates.hunter.trackpoints')
    def trackpoints(self, player_name=None, **kw):
        if player_name:
            result = DBSession.query(PlayerRecord).filter_by(player_name=player_name).order_by(PlayerRecord.updated.desc()).all()
        else:
            result= None

        if not result:
            result = None
            candi_players = DBSession.query(Player).filter(Player.name.contains(player_name))
        else:
            candi_players = None

        return dict(_page='hunter>trackpoints', result=result, player_name=player_name, candi_players=candi_players)