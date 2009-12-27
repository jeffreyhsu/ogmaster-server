## -*- coding: utf-8 -*-
<%inherit file="local:templates.master"/>
<%namespace name="common" file="local:templates._shared.common" import="*"/>

<%def name="title()">
    Track points - Welcome to Ogame Master
</%def>

<%def name="body_class()">
    short-head
</%def>

<%def name="head_additional()">
<link rel="stylesheet" type="text/css" href="${tg.url('/css/style.css')}" media="all" />
<link rel="stylesheet" type="text/css" href="${tg.url('/css/global.css')}" media="all" />
<link rel="stylesheet" type="text/css" href="${tg.url('/css/droppy.css')}" media="all" />
<link rel="stylesheet" type="text/css" href="${tg.url('/css/form.css')}" media="all" />
<link rel="stylesheet" type="text/css" href="${tg.url('/css/table.css')}" media="all" />
<link rel="stylesheet" type="text/css" href="${tg.url('/css/jquery.autocomplete.css')}" media="all" />

<script type="text/javascript" src="/js/jquery.autocomplete.min.js"></script>
<script type="text/javascript" src="/js/jquery.validate.min.js"></script>

<script type="text/javascript">
    $(function() {
        $.getJSON('/get_player_names', function(data) {
            names = data.names;
            $("#player_name_ipt").autocomplete(names, {
                autoFill: true
            });
        });

        $("form#trackpoints").submit(function() {
            if ($("input#player_name_ipt").val() == '') {
                return false;
            };
        });
    });
</script>
</%def>

<!-- begin body -->
<div id="bd" class="inner-bd">
    <div id="doc4" class="yui-t6">
        <div id="breadcrumbs">
            <a href="/">OGAME Master</a>
            &gt; <a href="/hunter/trackpoints"  class="selected">积分跟踪</a>
        </div>
        <!-- begin content -->

        <a name="content"></a>

        <ul class="nav">
            <li id="menu_account_index_index" style="z-index: 1000;"><a href="/hunter"><span><span>搜索目标</span></span></a></li>
            <li id="menu_account_services_index" class="${common.current('trackpoints', 2, 'selected tier')}" style="z-index: 1000;"><a href="/hunter/trackpoints" style="z-index: 1003;"><span><span>积分跟踪</span></span></a></li>
        </ul>

        <div style="clear: both;"/>

        <div class="sfBox b-hot" style="margin-top:10px;">
            <h2 class="titlebar">请输入玩家名称，查看他的积分和排名变化</h2>

            <form id="trackpoints" action="/hunter/trackpoints" method="get">
                <h4 class="error hide">

                </h4>
                <h4 class="info hide">
                </h4>
                <div id="project_unixname_div">
                    <label for="player_name">玩家名：</label>
                    <input id="player_name_ipt" name="player_name" type="text" value="${player_name}" />
                    <input type="submit" value="搜索" />
                </div>
            </form>

            % if candi_players:
            <ul>
                % for p in candi_players:
                <li>
                    <a href="${tg.url('/hunter/trackpoints', player_name=p.name)}">${p.name}</a>
                </li>
                % endfor
            </ul>
            % endif

            % if result:
            <table id="stat" class="table">
                <thead>
                    <tr>
                        <th width="120px;">玩家</th>
                        <th width="50px;">排名</th>
                        <th width="50px;">积分</th>
                        <th width="100px;">联盟</th>
                        <th width="100px;">本次更新时间</th>
                    </tr>
                </thead>
                <tbody>
                    % for row in result:
                    <tr>
                        <td><a href="http://ogame.gamestats.org/org/104/details/player/${row.player_name}" target="_blank">${row.player_name}</a></td>
                        <td>${row.rank}</td>
                        <td>${common.formate_number(row.points)}</td>
                        <td><a href="http://ogame.gamestats.org/org/104/details/ally/${row.ally}" target="_blank" class="ally">${row.ally}</a></td>
                        <td>${row.updated}</td>
                    </tr>
                    % endfor
                </tbody>
            </table>
            % endif

        </div>

    </div>
</div>
<!-- end body -->