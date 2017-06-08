--TEST--
date_default_timezone_get() function [2]
--INI--
date.timezone=CEST
--FILE--
<?php
	putenv('TZ=');
	echo date_default_timezone_get(), "\n";
?>
--EXPECTF--
System/Localtime