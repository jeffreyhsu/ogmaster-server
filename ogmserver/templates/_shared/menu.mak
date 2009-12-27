<%namespace file="local:templates._shared.common" import="*"/>

<!-- begin nav -->
<div class="yui-u first">
    <ul id="nav">
        <li class="first ${current('index', 1, 'active')}"><a href="#" title="comming soon">搜索宇宙</a></li>
        <li><a href="#" title="comming soon">作战中心</a></li>
        <li class="${current('hunter', 1, 'active')}"><a href="/hunter" title="">找羊工具</a></li>
        <li><a href="#" title="comming soon">情报中心</a></li>
        <li class="last ${current('about', 1, 'active')}"><a href="/about">关于OgameMaster</a></li>
    </ul>
</div>
<!-- end nav -->