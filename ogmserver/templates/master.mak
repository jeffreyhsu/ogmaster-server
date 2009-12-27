## -*- coding: utf-8 -*- 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        ${self.meta()}
        <title>${self.title()}</title>
        <link rel="stylesheet" type="text/css" media="screen" href="${tg.url('/css/ogame.css')}" />
        <script type="text/javascript" src="${tg.url('/js/jquery-1.3.2.min.js')}"></script>
        <script type="text/javascript" src="${tg.url('/js/jquery.validate.min.js')}"></script>
        ${self.head_additional()}

        <script type="text/javascript">
            var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
            document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
        </script>
        <script type="text/javascript">
            try {
                var pageTracker = _gat._getTracker("UA-1194322-5");
                pageTracker._trackPageview();
            } catch(err) {}</script>
    </head>

    <body class="${self.body_class()}">
        <div id="doc3">
            ${self.header()}
            ${self.content_wrapper()}
            ${self.footer()}
        </div>
    </body>

    <%def name="content_wrapper()">
    ${self.body()}
    </%def>

    <%def name="body_class()">
    </%def>

    <%def name="meta()">
    <meta content="text/html; charset=UTF-8" http-equiv="content-type"/>
    </%def>

    <%def name="title()">
    </%def>

    <%def name="head_additional()">
    </%def>

    <%def name="header()">
    <%include file="local:templates._shared.header"/>
    </%def>

    <%def name="footer()">
    <%include file="local:templates._shared.footer"/>
    </%def>

</html>