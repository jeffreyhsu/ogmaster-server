<%inherit file="local:templates.master"/>

<%def name="title()">
    Welcome to Ogame Master
</%def>

<%def name="body_class()">
    front
</%def>

<%def name="head_additional()">
    <link rel="stylesheet" type="text/css" media="screen" href="${tg.url('/css/sf.css')}" />
</%def>


<%def name="header()">
<div id="hd">
    <div class="yui-b">
        <%include file="local:templates._shared.meta_nav"/>

        <a href="/" title="" id="logo">Master the whole universe</a>

        <%include file="local:templates._shared.menu"/>
        
        <!-- begin additional -->
        <div id="additional-h" class="yui-g">
            <div class="yui-u">
                <div class="header head-main">
                    <h1>SourceForge is your location to download and develop <strong>free open source software.</strong></h1>
                </div>
                <div class="clearfix">
                    <a href="/about" class="button"><span>Learn more about SourceForge</span></a>
                    <a href="http://sourceforge.net/apps/trac/sourceforge/wiki/What%20is%20Open%20Source%20software" class="dotted-link">What is open source software?</a>
                </div>
            </div>
            <div class="yui-u first">
                <div class="header head-sub">
                    <h3>搜索玩家和联盟</h3>
                </div>

                <div class="sfBox search">
                    <form action="/search/" method="get">
                        <input type="hidden" value="soft" name="type_of_search"/>
                        <input type="text" class="text clear hint" name="words" value="" />
                        <span class="yui-button yui-push-button default">
                            <span class="first-child">
                                <button type="submit" value="Search">搜索</button>
                            </span>

                        </span>
                    </form>
                </div>
            </div>
        </div>
        <!-- end additional -->
    </div>
</div>
</%def>

<%def name="footer()">
<div class="clearfix" id="ft">
    <div class="yui-b">
        <p class="copyright">Copyright © 2009 <a href="http://geek.net" title="Network which provides and promotes Open Source software downloads, development, discussion and news.">Geeknet, Inc.</a> All rights reserved. <a href="http://p.sf.net/sourceforge/terms">Terms of Use</a></p>
    </div>
</div>
</%def>