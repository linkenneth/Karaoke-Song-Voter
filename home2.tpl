<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Home</title>
<script language="Javascript">
    function buttonClicked(frm)
    {
        if(frm.sessionName.value == "")
        {
            alert("Please input a Session name")
        }
        else
        {
            window.location.href = 'vote/'+ encodeURIComponent(frm.sessionName.value) + '/search';
        }
    }
	function update(event)
	{
    	if (event.keyCode==13)
    	{
        	this.buttonClicked(this.form);
    	}
	}
</script>

<style>
    body{
	padding:0;
	margin:0;
	font-family:"Myriad Pro";
	font-size:12px;
	color:#4874a1;
	background-color:#FFF;
	background-repeat:repeat-x;
	background-image: url(http://i.imgur.com/lUByo.jpg);
    }
</style>
</head>
<body>
  <form action="/create" method="POST">
  	<input type="text" name="sessionName" onkeydown="update(event)" style= "position:absolute; top: 200px; left: 475px; width: 113px;"/>
	<input type="submit" value= "Create Session" style= "position: absolute; top: 200px; left:593px; width: 107px;"/>
</form>
</body>
</html>
