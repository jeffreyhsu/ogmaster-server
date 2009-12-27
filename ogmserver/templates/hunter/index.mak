## -*- coding: utf-8 -*-
<%inherit file="local:templates.master"/>
<%namespace name="common" file="local:templates._shared.common" import="*"/>

<%def name="title()">
Find Sheep - Welcome to Ogame Master
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


<script type="text/javascript">
    $(function() {
        $("#stat tr:even").addClass("even");

        $(".showCoordinate").click(function() {
            $(this).parent().hide();
            $(".coordinate").fadeIn();
            $(".info").fadeIn();
            return false;
        });
        $(".closeCoordinate").click(function() {
            $(this).parent().hide();
            $(".showCoordinate").parent().show();
            $(".coordinate input").attr("value", "");
            $(".info").fadeOut();
            return false;
        })

        $("input#rank_start, input#rank_end, input#galaxy, input#system").click(function() {
            $(this).val('');
        });

        $("input#rank_start, input#rank_end, input#galaxy, input#system").change(function() {
            v = parseInt($(this).val());
            max = parseInt($(this).attr("max"));
            min = parseInt($(this).attr("min"));
            if (v > max) {
                $(this).val(max);
            };
            if (v < min) {
                $(this).val(min);
            }
        });

        $("#hunterSearch").submit(function() {
            if ($('input#galaxy').val() && $('input#system').val() == '') {
                $(".error").show().html("请输入太阳系坐标").fadeOut(3000);
                return false;
            }
            if ($('input#system').val() && $('input#galaxy').val() == '') {
                $(".error").show().html("请输入银河系坐标").fadeOut(3000);
                return false;
            }
        });
        
    });
    
    function set_filter_type(type) {
    	$("form#filter_result input#filter_type") = type;
    }
</script>
</%def>

<!-- begin body -->
<div id="bd" class="inner-bd">
    <div id="doc4" class="yui-t6">
        <div id="breadcrumbs">
            <a href="/">OGAME Master</a>
            &gt; <a href="/find"  class="selected">找羊工具</a>
        </div>
        <!-- begin content -->

        <ul class="nav">
            <li class="selected tier" id="menu_account_index_index" style="z-index: 1000;"><a href="/hunter"><span><span>搜索目标</span></span></a></li>
            <li id="menu_account_services_index" class="" style="z-index: 1000;"><a href="/hunter/trackpoints" style="z-index: 1003;"><span><span>积分跟踪</span></span></a></li>
        </ul>

        <div style="clear: both;"/>

        <div class="sfBox b-hot" style="margin-top:10px;">
            <h2 class="titlebar">Let me guess, who is the next?</h2>

            <form id="hunterSearch" action="/hunter/search" method="get">
                <h4 class="error hide">

                </h4>
                <h4 class="info hide">
                    输入坐标，寻找周围不活跃的玩家（积分停止增长）
                </h4>
                <div id="project_unixname_div">
                    <p>
                        <label>不活动时间></label>
                        <select name="hours">
                            <option value="6" ${'selected="selected"' if params['hours'] == '6' else ' '}>6小时</option>
                            <option value="12" ${'selected="selected"' if params['hours'] == '12' else ' '}>12小时</option>

                            <option value="24" ${'selected="selected"' if params['hours'] == '24' else ' '}>24小时</option>
                            <option value="48" ${'selected="selected"' if params['hours'] == '48' else ' '}>48小时</option>
                            <option value="72" ${'selected="selected"' if params['hours'] == '72' else ' '}>72小时</option>
                        </select>
                        &nbsp;
                        <label>排名</label>
                        <input id="rank_start" name="rank_start" type="text" maxlength="4" min="1" max="9999" style="width:40px;" value="${params['rank_start']}"/>
                        -
                        <input id="rank_end" name="rank_end" type="text" maxlength="4" min="1" max="9999" style="width:40px;" value="${params['rank_end']}"/>
                        <label>之间</label>
                        <input type="submit" value="搜索" />
                    </p>
                    <p>
                        <span class="${'hide' if params.get('galaxy') else ''}">
                            >><a href="#" style="border-bottom:1px dashed #0092E8;" class="showCoordinate">输入坐标</a>，筛选离此坐标最近的玩家
                        </span>
                        <span class="coordinate ${'' if params.get('galaxy') else 'hide'}" style="border:1px dashed #666; padding:6px 5px;">
                            <label>坐标：</label>
                            <input id="galaxy" name="galaxy" min="1" max="9" type="text" maxlength="1" style="width:1em;" value="${params.get('galaxy')}"/>
                            :
                            <input id="system" name="system" min="1" max="499" type="text" maxlength="3" style="width:3em;" value="${params.get('system')}"/>
                            <label>半径</label>
                            <select name="distance">
                                <option ${'selected="selected"' if params.get('distance') == '10' else ' '}>10</option>
                                <option ${'selected="selected"' if params.get('distance') == '20' else ' '}>20</option>
                                <option ${'selected="selected"' if params.get('distance') == '30' else ' '}>30</option>
                                <option ${'selected="selected"' if params.get('distance') == '40' else ' '}>40</option>
                                <option ${'selected="selected"' if params.get('distance') == '50' else ' '}>50</option>
                                <option ${'selected="selected"' if params.get('distance') == '60' else ' '}>60</option>
                                <option ${'selected="selected"' if params.get('distance') == '70' else ' '}>70</option>
                                <option ${'selected="selected"' if params.get('distance') == '80' else ' '}>80</option>
                                <option ${'selected="selected"' if params.get('distance') == '90' else ' '}>90</option>
                                <option ${'selected="selected"' if params.get('distance') == '170' else ' '}>170</option>
                            </select>
                            太阳系
                            <a href="#" class="closeCoordinate" style="border-bottom:1px dashed #0092e8;">取消</a>
                        </span>
                    </p>
                </div>
            </form>
                       
            <div class="yui-gf toolbar">
	            	<div class="yui-u first" style="width:50%">共找到 
	            		<strong>${result.item_count}</strong>
	            		% if params.get('galaxy') and params.get('system'):
	            			个超过${params['hours']}小时不活跃的星球，距离坐标[${params['galaxy']}:${params['system']}]${params.get('distance')}太阳系以内
	            		% else:
	            			个超过${params['hours']}小时不活跃的玩家：
	            		% endif
            		</div>
            		<strong>    </strong>
            		<!--
            		<div class="yui-u right" style="width:50%">
            			<strong>                    </strong>
            				<form action="${tg.url('hunter/search', **params)}" method="get">
            					<strong>
            					<input id="filter_type" type="hidden" value="" name="filter_type"/>
                            	显示:
                            	<span class="nosel ${common.current('novacation', 3, 'sel')}" id="meta0_0" onclick="set_filter_type('novacation');return false;"><a href="/">不含假期</a></span>
            					<span class="nosel ${common.current('all', 3, 'sel')}" id="ss0_0" onclick="set_filter_type('all');return false;"><a href="/">全部</a></span>
        						</strong>
        					</form>
							<strong>    </strong>
					</div>
					-->
			</div>
			
			<div class="pager">
                ${result.pager('$link_previous ~2~ $link_next', **params)}
            </div>
            
            <table id="stat" class="table">
                <thead>
                    <tr>
                        <th width="120px;">玩家</th>
                        <th width="50px;">排名</th>
                        <th width="50px;">积分</th>
                        <th width="100px;">联盟</th>
                        <th width="100px;">本次更新时间</th>
                        <th width="100px;">星球坐标</th>
                        <th width="100px;">相距(太阳系)</th>
                        
                    </tr>
                </thead>
                <tbody>
                    % for row in result:
                    <tr>
                        <td><a href="http://ogame.gamestats.org/org/104/details/player/${row['player_name']}" target="_blank">${row['player_name'] if row.has_key('player_name') else ''}</a>${common.show_status(row['_status']) | n}</td>
                        <td>${row['rank'] if row.has_key('rank') else ''}</td>
                        <td><a href="${tg.url('/hunter/trackpoints', player_name=row['player_name'])}">${formate_number(row['points']) if row.has_key('points') else ''}</a></td>
                        <td><a href="http://ogame.gamestats.org/org/104/details/ally/${row['ally']}" target="_blank" class="ally">${row['ally'] if row.has_key('ally') else ''}</a></td>
                        <td>${row['updated'] if row.has_key('updated') else ''}</td>
                        <td>${row['_coord'] if row.has_key('_coord') else ''}</td>
                        <td>${row['d'] if row.has_key('d') else ''}</td>
                    </tr>
                    % endfor
                </tbody>
            </table>
            <div class="pager">
                ${result.pager('$link_previous ~2~ $link_next', **params)}
            </div>

        </div>

    </div>
</div>
<!-- end body -->