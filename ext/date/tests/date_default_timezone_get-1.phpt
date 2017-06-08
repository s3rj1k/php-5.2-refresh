--TEST--
date_default_timezone_get() function [1]
--INI--
date.timezone=
--FILE--
<?php
	putenv('TZ=');
	echo date_default_timezone_get(), "\n";
	echo date('e'), "\n";
?>
--EXPECTF--
System/Localtime
System/Localtime