<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class IndexController extends Controller
{
    function index() {
        return view('index') 
            ->with('twitter_public_total', $this->twitter_public->count())
            ->with('twitter_private_total', $this->twitter_private->count())
            ->with('instagram_public_total', $this->instagram_public->count())
            ->with('instagram_private_total', $this->instagram_private->count());
    }
}
