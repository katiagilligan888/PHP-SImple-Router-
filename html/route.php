<?php

class Route 
{
    private $_uri = array();

    public function add($uri, $method = null)
    {
        $this->_uri[] = $uri;

        if($method != null){
            $this->_method[] = $method;
        }
    }

    public function submit()
    {
        // recieve the uri from the server
        $uriParam = isset($_SERVER["REQUEST_URI"]) ? $_SERVER["REQUEST_URI"] : '/';
        // loop through each uri and find the one that matches the route
        foreach($this->_uri as $key => $value)
        {
            if(preg_match("#^$value$#", $uriParam))
            {
               $useMethod = $this->_method[$key];
               new $useMethod();
            }
        }
    }
}