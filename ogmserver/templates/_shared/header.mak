<!-- start header -->
<div id="hd">
    <div class="yui-b">
        <%include file="local:templates._shared.meta_nav"/>

        <a href="/" title="" id="logo"><strong style="font-size:12px;font-weight:bold;color:#000;">Preview </strong> Master the whole universe</a>
        
        <div class="yui-gc">
            <%include file="local:templates._shared.menu"/>

            <!-- begin search -->
            <div class="yui-u">
                <div class="search">
                    <form action="/" method="get" name="searchform">
                        <input type="hidden" name="type_of_search" value="soft" />
                        <input type="text" class="text clear hint" id="words" name="words" value="输入玩家名、联盟名称、坐标" />
                        <span class="yui-button yui-push-button default">
                            <span class="first-child">
                                <button type="submit" name="search" value="Search" disabled="disabled">Search</button>
                            </span>
                        </span>
                    </form>
                </div>
            </div>
            <!-- end search -->
        </div>
    </div>

</div>
<!-- end header -->