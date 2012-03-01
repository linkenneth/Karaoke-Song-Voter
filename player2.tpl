<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style>
body {
	background-image: url(http://i.imgur.com/J7n5y.jpg);
	background-repeat: repeat-x;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Player</title>

<script type='text/javascript' src='http://swfobject.googlecode.com/svn/trunk/swfobject/swfobject.js'></script>
<div id='ytapiplayer'>You need Flash Player 9+ and JavaScript enabled to view this video.</div>

<script type="text/javascript">
/* JavaScript calls post_next once the user presses the "Skip" button or if the video ends, which returns from the server a JSON dictionary with the vid_url, title, and img_url of the next video. JavaScript then proceeds to play the next video in the queue. */

function post_next()
{
    var http = new XMLHttpRequest();
    http.open("POST", "/play/{{content['session']}}/next", false);
    http.send(null);
    response = eval('(' + http.responseText + ')');
    return response['next'];
}

function get_top()
{
    var http = new XMLHttpRequest();
    http.open("GET", "/play/{{content['session']}}/top", false);
    http.send(null);
    response = eval('(' + http.responseText + ')');
    return response['top'];
}

function onYouTubePlayerReady(playerid) {
    ytplayer = document.getElementById('myytplayer');
    ytplayer.addEventListener("onStateChange", "onytplayerStateChange");
    next_vid();
}

function onytplayerStateChange(newState) {
    if (newState == 0) {
        next_vid();
    }
}

function next_vid() {
    vid = post_next();
    url = 'http://www.youtube.com/v/' + vid['vid_url'];
    ytplayer.loadVideoByUrl(url,0,'medium');
}
swfobject.embedSWF(
      'http://www.youtube.com/v/-gspiKeSIOY' + '&enablejsapi=1&playerapiid=ytplayer&rel=1&border=0&fs=1&autoplay=0', 'ytapiplayer', '640', '480', '9.0.0', false, false, {allowfullscreen: 'true', allowScriptAccess: "always"}, {id: 'myytplayer'});
	  
</script>
</head>
<body>
<p>
	<input type='button' onclick="next_vid()" value='Next' style='text-align:center; position: absolute; left:320px'/>
</p>
<table>

<tr>
	<td width="87"><img id='thumbnail' src='' /></td>
	<td width="203"><div id='upcoming' style="font-family:verdana;font-size:16px"></div></td>
</tr>
</table>
</body>
<script type='text/javascript'>
function updateUpcoming() {
    upcoming = get_top();
    if (upcoming != '') {
        upcomingDiv = document.getElementById('upcoming');
        upcomingDiv.innerHTML = upcoming['title'];
        thumbnailSource = document.getElementById('thumbnail');
        thumbnailSource.src = upcoming['thumbnail_url'];
    }
    setTimeout(updateUpcoming, 5000);
}
updateUpcoming();
</script>
</html>
