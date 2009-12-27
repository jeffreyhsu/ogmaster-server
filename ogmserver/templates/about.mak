## -*- coding: utf-8 -*-
<%inherit file="local:templates.master"/>
<%namespace name="common" file="local:templates._shared.common" import="*"/>

<%def name="title()">
About - Welcome to Ogame Master
</%def>

<%def name="body_class()">
short-head
</%def>

<%def name="head_additional()">
<link rel="stylesheet" type="text/css" href="${tg.url('/css/style.css')}" media="all" />
<link rel="stylesheet" type="text/css" href="${tg.url('/css/global.css')}" media="all" />

<script type="text/javascript">
    $(function() {        
    });
</script>
</%def>

<!-- begin body -->
<div id="bd" class="inner-bd">
    <div id="doc4" class="yui-t6">
        <div id="breadcrumbs">
            <a href="/">OGAME Master</a>
            &gt; <a href="/about"  class="selected">About</a>
        </div>
        <!-- begin content -->

        <p>
        	Official Blog: <a href="http://www.jeffreyxu.com/blog/category/ogamemaster/">http://jeffreyxu.com/blog/category/ogamemaster/</a>
        </p>
        <p>
			&nbsp;&nbsp;&nbsp;&nbsp;作者<a href="jeffreyxu@gmail.com">jeffrey</a>是Ogame资深玩家和一名Geek Programmer，在长期征战中积累了丰富经验，并编写出各种统计分析工具和game bot来辅助游戏。现将这些工具逐步提炼开放出来，制作成在线版本，供各位ogame战友使用，帮助你一统宇宙。
        </p>

    </div>
</div>
<!-- end body -->