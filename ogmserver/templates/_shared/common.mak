<%def name="formate_number(d)">
<%
    s = '%s' % d
    l = []
    while len(s) > 3:
        l.insert(0,s[-3:])
        s = s[0:-3]
    if s:
        l.insert(0,s)
    return ','.join(l)
%>
</%def>

<%def name="current(c, idx=1, cls='selected')">
<%
    return cls if _page.split('>')[idx-1] == c else ''
%>
</%def>

<%def name="show_status(status)">
<%
    status = eval(status)
    s = ''
    if 'i' in status:
        s = s + '<span class="status_i">i</span>'
    elif 'I' in status:
        s = s + '<span class="status_I">I</span>'
    elif 'v' in status:
        s = s + '<span class="status_v">v</span>'
    elif 'b' in status:
        s = s + '<span class="status_b">b</span>'
    if s:
        s = '(' + s + ')'
    return s
%>
</%def>