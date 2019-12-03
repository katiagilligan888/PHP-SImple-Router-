<?php

class Core
{
    public function __construct()
    {
        echo "this is the CORE page";
        $this->_other();

    }
    
    protected function _other()
    {
        echo 'This is the other function, lolol';
    }
}