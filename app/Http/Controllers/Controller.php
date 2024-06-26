<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Facades\DB;

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;

    protected $twitter_public;
    protected $twitter_private;
    protected $instagram_public;
    protected $instagram_private;
    protected $instagram_followers_private;
    protected $instagram_following_private;
    protected $twitter_followers_private;
    protected $twitter_following_private;
    protected $instagram_login_history_private;
    protected $twitter_ip_audit;

    function __construct()
    {
        // Twitter Models
        $this->twitter_public = new \App\Models\Views\TwitterPublic;
        $this->twitter_private = new \App\Models\Views\TwitterPrivate;

        // Instagram Models
        $this->instagram_public = new \App\Models\Views\InstagramPublic;
        $this->instagram_private = new \App\Models\Views\InstagramPrivate;

        // Other Models
        $this->instagram_followers_private = DB::table('instagram.followers_private');
        $this->instagram_following_private = DB::table('instagram.following_private');
        $this->twitter_followers_private = DB::table('twitter.followers_private');
        $this->twitter_following_private = DB::table('twitter.following_private');
        $this->instagram_login_history_private = DB::table('instagram.account_history_login_private');
        $this->twitter_ip_audit = DB::table('twitter.ip_audit_private');
    }
}
