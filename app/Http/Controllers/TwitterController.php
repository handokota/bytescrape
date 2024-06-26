<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
class TwitterController extends Controller
{
    protected $fields;

    function __construct()
    {
        // This fields are used for the table header
        // and datatable column name response

        // This fields are taken from the Instagram Public and Private data list
        // and take only one field from same data list to be displayed in the table
        $this->fields = [
            "user_name" => "Username",
            "id" => "ID",
            "name" => "Name",
            "followers" => "Followers",
            "following" => "Following",
            "description" => "Description",
            "profile_picture" => "Profile Picture",
            "cover_picture" => "Cover Picture",
            "location" => "Location",
            "user_created_at" => "User Created At",
            "timezone" => "Timezone",
            "user_creation_ip" => "User Creation IP",
            "email" => "Email",
            "phone_number" => "Phone Number",
            "birth_date" => "Birth Date",
            "twitter_url" => "Twitter URL",
            "entry_id" => "Entry ID",
            "tweet_created_at" => "Tweet Created At",
            "full_text" => "Full Text",
            "media_url" => "Media URL",
            "retweet_count" => "Retweet Count",
            "reply_count" => "Reply Count",
            "like_count" => "Like Count",
            "quote_count" => "Quote Count",
            "keyword" => "Keyword",
            "sentiment_analysis" => "Sentiment Analysis",
            "content_type" => "Content Type"
        ];

        parent::__construct();
    }

    function index() {
        return view('pages.twitter.index')
                ->with('fields', $this->fields);
    }

    function dt() {
        // Get the fields for the datatable response
        $fields = $this->fields;

        // Get the public and private data
        $public_data = $this->twitter_public->get() -> toArray();
        $private_data = $this->twitter_private->get() -> toArray();

        // Merge public and private data collection
        $data = collect($public_data) -> merge(collect($private_data));

        // Order by user_id
        $data = $data->sortBy('user_id');
    
        // Remove user_id from the fields for display purposes
        unset($fields['user_id']);

        // return the data as datatable response
        return datatables()
                ->of($data)
                ->with('fields', $fields)
                ->setTransformer(function($data) use ($fields) {
                    $result = [];
                    foreach ($fields as $key => $value) {
                        if (in_array($key, ['tweet_created_at', 'birth_date', 'user_created_at'])) {
                            // convert to GMT 00:00
                            $result[$key] = !empty($data[$key]) ? Carbon::parse($data[$key])->setTimezone('GMT')->format('Y-m-d H:i:sP') : null;
                        } else if($key == 'followers') {
                            $result[$key] = !empty($data['followers']) ? '<a href="#" onClick="followers_modal('.$data['user_id'].')" class="text-blue-500">'.$data['followers'].'</a>' : 0;
                        } else if($key == 'following') {
                            $result[$key] = !empty($data['following']) ? '<a href="#" onClick="following_modal('.$data['user_id'].')" class="text-blue-500">'.$data['following'].'</a>' : 0;
                        } else if($key == 'user_creation_ip') {
                            $result[$key] = !empty($data['user_creation_ip']) ? '<a href="#" onClick="ip_modal('.$data['user_id'].')" class="text-blue-500">'.$data['user_creation_ip'].'</a>' : '';
                        } else {
                            $result[$key] = $data[$key] ?? null;
                        }
                    }

                    return $result;
                })
                ->make(true);
    }

    function followers_private(Request $request) {
        if (!$request->has('user_id')) {
            return '<p>user_id is required</p>';
        }

        $data = $this->twitter_followers_private
                ->select('id', 'user_link')
                ->where('user_id', $request->user_id)
                ->get();
        
        if ($data->isEmpty()) {
            return '<p>No data found</p>';
        }

        $table = '<table class="display">';
        $table .= '<thead>';
        $table .= '<tr>';
        $table .= '<th>ID</th>';
        $table .= '<th>User Link</th>';
        $table .= '</tr>';

        $table .= '<tbody>';
        foreach ($data as $row) {
            $table .= '<tr>';
            $table .= '<td>'.$row->id.'</td>';
            $table .= '<td>'.$row->user_link.'</td>';
            $table .= '</tr>';
        }
        $table .= '</tbody>';

        return $table;
    }

    function following_private(Request $request) {
        if (!$request->has('user_id')) {
            return '<p>user_id is required</p>';
        }

        $data = $this->twitter_following_private
                ->select('id', 'user_link')
                ->where('user_id', $request->user_id)
                ->get();

        if ($data->isEmpty()) {
            return '<p>No data found</p>';
        }

        $table = '<table class="display">';
        $table .= '<thead>';
        $table .= '<tr>';
        $table .= '<th>ID</th>';
        $table .= '<th>User Link</th>';
        $table .= '</tr>';

        $table .= '<tbody>';
        foreach ($data as $row) {
            $table .= '<tr>';
            $table .= '<td>'.$row->id.'</td>';
            $table .= '<td>'.$row->user_link.'</td>';
            $table .= '</tr>';
        }
        $table .= '</tbody>';

        return $table;
    }

    function ip_audit(Request $request) {
        if (!$request->has('user_id')) {
            return '<p>user_id is required</p>';
        }

        $data = $this->twitter_ip_audit
                        ->select('login_ip', 'created_at')
                        ->where('user_id', $request->user_id)
                        ->get();

        if ($data->isEmpty()) {
            return '<p>No data found</p>';
        }

        $table = '<table class="display">';
        $table .= '<thead>';
        $table .= '<tr>';
        $table .= '<th>Login IP</th>';
        $table .= '<th>Created At</th>';
        $table .= '</tr>';

        $table .= '<tbody>';
        foreach ($data as $row) {
            $table .= '<tr>';
            $table .= '<td>'.$row->login_ip.'</td>';
            $table .= '<td>'.Carbon::parse($row->created_at)->setTimezone('GMT')->format('Y-m-d H:i:s').'</td>';
            $table .= '</tr>';
        }
        $table .= '</tbody>';
        return $table;
    }
}
