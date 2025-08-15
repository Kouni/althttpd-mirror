<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<base href="https://sqlite.org/althttpd/login">
<meta http-equiv="Content-Security-Policy" content="default-src 'self' data:; script-src 'self' 'nonce-5adc12124756ec4e08ea60d68969bee57808b34a4521640e'; style-src 'self' 'unsafe-inline'; img-src * data:">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Althttpd: Login/Logout</title>
<link rel="alternate" type="application/rss+xml" title="RSS Feed"  href="/althttpd/timeline.rss">
<link rel="stylesheet" href="/althttpd/style.css?id=a1528015" type="text/css">
</head>
<body class="login rpage-login cpage-login">
<header>
  <div class="title"><h1>Althttpd</h1>Login/Logout</div>
  <div class="status">
    <a href='/althttpd/login'>Login</a>

  </div>
</header>
<nav class="mainmenu" title="Main Menu">
  <a id='hbbtn' href='/althttpd/sitemap' aria-label='Site Map'>&#9776;</a><a href='/althttpd/home' class=''>Home</a>
<a href='/althttpd/forum' class=''>Forum</a>

</nav>
<nav id="hbdrop" class='hbdrop' title="sitemap"></nav>
<div class="content"><span id="debugMsg"></span>

<p>Login as a named user to access page <b>raw/standalone-mode.md</b>.
<form method="POST" data-action='/althttpd/login' action='/althttpd/login' >
<input type="hidden" name="csrf" value="X4NxUm8fHjwVYdN">
<input type="hidden" name="g" value="raw/standalone-mode.md?at=trunk">
<table class="login_out">
<tr>
  <td class="form_label" id="userlabel1">User ID:</td>
  <td><input type="text" id="u" aria-labelledby="userlabel1" name="u" size="30" value="" autofocus></td>
</tr>
<tr>
 <td class="form_label" id="pswdlabel">Password:</td>
 <td><input aria-labelledby="pswdlabel" type="password" id="p" name="p" value="" size="30">
</td>
</tr>
<tr>
  <td></td>
  <td><input type="checkbox" name="remember" value="1" id="remember-me" >
  <label for="remember-me">Remember me?</label></td>
</tr>
<tr>
  <td></td>
  <td><input type="submit" name="in" value="Login">
</tr>
<tr>
  <td></td>
  <td><input type="submit" name="self" value="Create A New Account">
</tr>
<tr>
  <td></td>
  <td><input type="submit" name="pwreset" value="Reset My Password">
</tr>
</table>
</form>
<hr><p>
Select your preferred <a href="/althttpd/skins">site skin</a>.
</p>
<hr><p>
Manage your <a href="/althttpd/cookies">cookies</a>.</p>
</div>
<footer>
This page was generated in about
0.004s by
Fossil 2.27 [e58112a4f3] 2025-08-14 21:01:53
</footer>
<script nonce="5adc12124756ec4e08ea60d68969bee57808b34a4521640e">/* style.c:899 */
function debugMsg(msg){
var n = document.getElementById("debugMsg");
if(n){n.textContent=msg;}
}
</script>
<script nonce='5adc12124756ec4e08ea60d68969bee57808b34a4521640e'>
/* hbmenu.js *************************************************************/
(function() {
var hbButton = document.getElementById("hbbtn");
if (!hbButton) return;
if (!document.addEventListener) return;
var panel = document.getElementById("hbdrop");
if (!panel) return;
if (!panel.style) return;
var panelBorder = panel.style.border;
var panelInitialized = false;
var panelResetBorderTimerID = 0;
var animate = panel.style.transition !== null && (typeof(panel.style.transition) == "string");
var animMS = panel.getAttribute("data-anim-ms");
if (animMS) {
animMS = parseInt(animMS);
if (isNaN(animMS) || animMS == 0)
animate = false;
else if (animMS < 0)
animMS = 400;
}
else
animMS = 400;
var panelHeight;
function calculatePanelHeight() {
panel.style.maxHeight = '';
var es   = window.getComputedStyle(panel),
edis = es.display,
epos = es.position,
evis = es.visibility;
panel.style.visibility = 'hidden';
panel.style.position   = 'absolute';
panel.style.display    = 'block';
panelHeight = panel.offsetHeight + 'px';
panel.style.display    = edis;
panel.style.position   = epos;
panel.style.visibility = evis;
}
function showPanel() {
if (panelResetBorderTimerID) {
clearTimeout(panelResetBorderTimerID);
panelResetBorderTimerID = 0;
}
if (animate) {
if (!panelInitialized) {
panelInitialized = true;
calculatePanelHeight();
panel.style.transition = 'max-height ' + animMS +
'ms ease-in-out';
panel.style.overflowY  = 'hidden';
panel.style.maxHeight  = '0';
}
setTimeout(function() {
panel.style.maxHeight = panelHeight;
panel.style.border    = panelBorder;
}, 40);
}
panel.style.display = 'block';
document.addEventListener('keydown',panelKeydown,true);
document.addEventListener('click',panelClick,false);
}
var panelKeydown = function(event) {
var key = event.which || event.keyCode;
if (key == 27) {
event.stopPropagation();
panelToggle(true);
}
};
var panelClick = function(event) {
if (!panel.contains(event.target)) {
panelToggle(true);
}
};
function panelShowing() {
if (animate) {
return panel.style.maxHeight == panelHeight;
}
else {
return panel.style.display == 'block';
}
}
function hasChildren(element) {
var childElement = element.firstChild;
while (childElement) {
if (childElement.nodeType == 1)
return true;
childElement = childElement.nextSibling;
}
return false;
}
window.addEventListener('resize',function(event) {
panelInitialized = false;
},false);
hbButton.addEventListener('click',function(event) {
event.stopPropagation();
event.preventDefault();
panelToggle(false);
},false);
function panelToggle(suppressAnimation) {
if (panelShowing()) {
document.removeEventListener('keydown',panelKeydown,true);
document.removeEventListener('click',panelClick,false);
if (animate) {
if (suppressAnimation) {
var transition = panel.style.transition;
panel.style.transition = '';
panel.style.maxHeight = '0';
panel.style.border = 'none';
setTimeout(function() {
panel.style.transition = transition;
}, 40);
}
else {
panel.style.maxHeight = '0';
panelResetBorderTimerID = setTimeout(function() {
panel.style.border = 'none';
panelResetBorderTimerID = 0;
}, animMS);
}
}
else {
panel.style.display = 'none';
}
}
else {
if (!hasChildren(panel)) {
var xhr = new XMLHttpRequest();
xhr.onload = function() {
var doc = xhr.responseXML;
if (doc) {
var sm = doc.querySelector("ul#sitemap");
if (sm && xhr.status == 200) {
panel.innerHTML = sm.outerHTML;
showPanel();
}
}
}
var url = hbButton.href + (hbButton.href.includes("?")?"&popup":"?popup")
xhr.open("GET", url);
xhr.responseType = "document";
xhr.send();
}
else {
showPanel();
}
}
}
})();
</script>
</body>
</html>
