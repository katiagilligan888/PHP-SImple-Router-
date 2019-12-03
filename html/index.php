<?php
include 'route.php';
include 'src/Core.php';
include 'src/UserPortal.php';
include 'src/Home.php';

$route = new Route();

$route->add('/', 'Home');
$route->add('/core', 'Core');
$route->add('/userportal','Userportal');

$route->submit();
