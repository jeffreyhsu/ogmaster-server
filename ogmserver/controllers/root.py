# -*- coding: utf-8 -*-
"""Main Controller"""

from sqlalchemy.sql import *

from tg import expose, flash, require, url, request, redirect
from pylons.i18n import ugettext as _, lazy_ugettext as l_
from tgext.admin.tgadminconfig import TGAdminConfig
from tgext.admin.controller import AdminController
from repoze.what import predicates

from ogmserver.lib.base import BaseController
from ogmserver.model import DBSession, metadata
from ogmserver.controllers.error import ErrorController
from ogmserver import model
from ogmserver.controllers.secure import SecureController
from ogmserver.controllers.hunter import HunterController

__all__ = ['RootController']


class RootController(BaseController):
    """
    The root controller for the ogmserver application.
    
    All the other controllers and WSGI applications should be mounted on this
    controller. For example::
    
        panel = ControlPanelController()
        another_app = AnotherWSGIApplication()
    
    Keep in mind that WSGI applications shouldn't be mounted directly: They
    must be wrapped around with :class:`tg.controllers.WSGIAppController`.
    
    """
    secc = SecureController()
    
    admin = AdminController(model, DBSession, config_type=TGAdminConfig)
    
    error = ErrorController()

    hunter = HunterController()

    @expose("json")
    def get_player_names(self):
        result = DBSession.query(model.PlayerRecord.player_name)\
            .filter(model.PlayerRecord.points>=1000)\
            .group_by(model.PlayerRecord.ogameid).all()
        return dict(names=[n[0] for n in result])

    @expose('ogmserver.templates.index')
    def index(self):
        """Handle the front-page."""
        redirect('/hunter')
#        return dict(_page='index')

    @expose('ogmserver.templates.about')
    def about(self):
        """Handle the 'about' page."""
        return dict(_page='about')

    @expose('ogmserver.templates.environ')
    def environ(self):
        """This method showcases TG's access to the wsgi environment."""
        return dict(environment=request.environ)

    @expose('ogmserver.templates.data')
    @expose('json')
    def data(self, **kw):
        """This method showcases how you can use the same controller for a data page and a display page"""
        return dict(params=kw)

    @expose('ogmserver.templates.authentication')
    def auth(self):
        """Display some information about auth* on this application."""
        return dict(page='auth')

    @expose('ogmserver.templates.index')
    @require(predicates.has_permission('manage', msg=l_('Only for managers')))
    def manage_permission_only(self, **kw):
        """Illustrate how a page for managers only works."""
        return dict(page='managers stuff')

    @expose('ogmserver.templates.index')
    @require(predicates.is_user('editor', msg=l_('Only for the editor')))
    def editor_user_only(self, **kw):
        """Illustrate how a page exclusive for the editor works."""
        return dict(page='editor stuff')

    @expose('ogmserver.templates.login')
    def login(self, came_from=url('/')):
        """Start the user login."""
        login_counter = request.environ['repoze.who.logins']
        if login_counter > 0:
            flash(_('Wrong credentials'), 'warning')
        return dict(page='login', login_counter=str(login_counter),
                    came_from=came_from)
    
    @expose()
    def post_login(self, came_from=url('/')):
        """
        Redirect the user to the initially requested page on successful
        authentication or redirect her back to the login page if login failed.
        
        """
        if not request.identity:
            login_counter = request.environ['repoze.who.logins'] + 1
            redirect(url('/login', came_from=came_from, __logins=login_counter))
        userid = request.identity['repoze.who.userid']
        flash(_('Welcome back, %s!') % userid)
        redirect(came_from)

    @expose()
    def post_logout(self, came_from=url('/')):
        """
        Redirect the user to the initially requested page on logout and say
        goodbye as well.
        
        """
        flash(_('We hope to see you soon!'))
        redirect(came_from)
