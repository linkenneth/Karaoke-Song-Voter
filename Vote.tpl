<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Karaoke Vote</title>
<!--[if lte IE 8]>
<script type="text/javascript" src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link href="desktop.css" rel="stylesheet" type="text/css">
</head>
<style type="text/css">
@charset "utf-8";
/* CSS Document */

article, aside, figure, footer, header, nav, section {
	display: block;
	margin: 0;
	padding: 0;
}
body {
	font-family: "Myriad Pro";
	color: #000;
	background-color: #FFFFFF;
	margin: 0px;
	padding: 0px;
	background-image: url(http://i.imgur.com/dWJvO.jpg);
	background-repeat: repeat-x;
	margin-top: 170px;
}
#container {
	width: 550px;
	padding-top: 10px;
	margin-top: 10px;
	margin-right: auto;
	margin-bottom: 0px;
	margin-left: 10px;
}
#logo h1, #logo h2 {
	position: absolute;
	top: -550px;
}
nav {
	padding-top: 0px;
}
#maincontent {
	margin-top: 10px;
	padding-top: 10px;
	padding-right: 0px;
	padding-bottom: 10px;
	padding-left: 0px;
}

ul {
	padding:0;
	margin:0;
}
nav ul {
	list-style: none;
	margin-bottom: 10px;
	font-weight: bold;
	font-size:15px;
}
nav ul li {
	padding-right: 5px;
	float: left;
}
nav ul a {
	display: block;
	width:60px;
	padding: 5px;
	text-align:center;
	text-decoration: none;
	color: #fff;
	border: 1px solid #4874A1;
	border-radius: 8px;
	-moz-box-shadow: 1px 1px 3px rgba(0,0,0,0.3);
	-webkit-box-shadow: 1px 1px 3px rgba(0,0,0,0.3);
	box-shadow: 1px 1px 3px rgba(0,0,0,0.3);
	text-shadow: 1px 1px 1px rgba(0,0,0,0.8);
	height: 20px;
	margin-top: -10px;
	margin-right: 0px;
	margin-bottom: 5px;
	margin-left: 0px;
	font-family: "Myriad Pro";
}
nav ul a:link, nav ul a:visited {
	background: rgba(255,255,255,0.2);
}
nav ul a:hover, nav ul a:active, nav ul a:focus {
	background: rgba(255,255,255,0.4);
}
nav ul li:hover {
	margin-top:-10px;
}
nav ul li {
	float: right;
	-webkit-transition-duration:.5s;
	-webkit-transition-property:margin-top;
	-webkit-transition-timing-function:ease-in-out;
	-o-transition-duration:.5s;
	-o-transition-property:margin-top;
	-o-transition-timing-function:ease-in-out;
	-moz-transition-duration:.5s;
	-moz-transition-property:margin-top;
	-moz-transition-timing-function:ease-in-out;
	transition-duration:.5s;
	transition-property:margin-top;
	transition-timing-function:ease-in-out;
}

.pod {
	background: #fff;
	padding: 10px;
	width: 500px;
	float:left;
	margin-right: 0px;
	margin-top: 10px;
	margin-bottom: 10px;
	margin-left: 0px;
	border: 2px solid #4874A1;
	margin: 5px 0px;
	border-radius: 16px;
	-moz-box-shadow: 1px 1px 3px rgba(0,0,0,0.3);
	-webkit-box-shadow: 1px 1px 3px rgba(0,0,0,0.3);
	box-shadow: 1px 1px 3px rgba(0,0,0,0.3);
	opacity: 0.5;
	filter: alpha(opacity=50);
 	-webkit-transition: opacity .3s linear;
	-moz-transition: opacity .3s linear;
	transition: opacity .3s linear;
}

.pod:hover {
	opacity: 1;
	filter: alpha(opacity=100);
 	-webkit-transition: opacity .3s linear;
	-moz-transition: opacity .3s linear;
	transition: opacity .3s linear;
}
.podContent {
	margin-top:10px;
	width: 120px;
	height:90px;
	overflow:hidden;
	text-align: left;
	float:left;
	font-family: "Myriad Pro";
}


</style>
<script language="Javascript">
    function buttonClicked(frm)
    {
        if(frm.query.value == "")
        {
            alert("Please input something or gtfo");
        }
        else
        {
            window.location = '/vote/{{content['session']}}?query='+ encodeURIComponent(frm.query.value);
        }
    }
</script>
</head>

<body>
<div id="container">
	<div id = "headerinner" style="overflow:hidden;width: 550px; padding-top: 10px;">
          <FORM>
            <div style="float:left">
  				<INPUT TYPE="TEXT" NAME="query">
           	  <INPUT TYPE="Button" Value="Search for a Video" onClick="buttonClicked(this.form)">
            </div>
            <div style="float:right">
                <header id="logo">
                  <h1>Karaoke</h1>
                  <h2>Sustainable, organic and natural</h2>
                  <nav>
                    <ul>
                      <li><a href="/vote/{{content['session']}}">Vote</a></li>
                      <li><a href="/play/{{content['session']}}">Play</a></li>
                    </ul>
                  </nav>
                </header>
              </div>
          </FORM>
    </div>
   
  	<div id="maincontent">
      % for vid in content['videos']:
        <div id="inner" style="overflow:hidden;width: 2000px">
          <section class="pod">
          	<figure class="podContent"><img src="{{vid["thumbnail_url"]}}" width="120" height="90" alt="specials"></figure>
            <div class="podContent" id="info" style="width: 260px; margin-left:10px">
                  <p>{{vid["title"]}}</p>
                  <p>{{vid["vid_time"]}}</p>
            </div>
            <form action = "/vote/{{content['session']}}/{{vid['id']}}/+" method="post">
              
              <div class="podContent" id="hide" style="width: 1px">
                  <input type="hidden" name="vid_url" value="{{vid["vid_url"]}}">
                  <input type="hidden" name="img_url" value="{{vid["thumbnail_url"]}}">
                  <input type="hidden" name="vid_title" value="{{vid["title"]}}">
                  <input type="hidden" name="vid_time" value="{{vid["vid_time"]}}">
              </div>
              <figure class="podContent" style="width:48px; height:70px; padding-top: -45px; text-align: right;">Score:<input type = "image" img src="http://i.imgur.com/4BXhS.png" width="48" height="48"/></figure>
              </form>
              <form action = "/vote/{{content['session']}}/{{vid['id']}}/-" method="post">
              
              <div class="podContent" id="hide" style="width: 1px">
                  <input type="hidden" name="vid_url" value="{{vid["vid_url"]}}">
                  <input type="hidden" name="img_url" value="{{vid["thumbnail_url"]}}">
                  <input type="hidden" name="vid_title" value="{{vid["title"]}}">
                  <input type="hidden" name="vid_time" value="{{vid["vid_time"]}}">
              </div>
              <figure class="podContent" style="width: 48px; height:70px; margin-left:5px; 	padding-top: -30px;">{{vid["score"]}}<input type = "image" img src="http://i.imgur.com/bcpLc.png" width="48" height="48"/></figure>
              </form>
            </section>
        </div>
	%end 
	</div>
</div>
</body>
</html>
