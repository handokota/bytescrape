<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

class InstagramController extends Controller
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
            "biography" => "Biography",
            "profile_picture" => "Profile Picture",
            "profile_pic_uri" => "Profile Picture URI",
            "location" => "Location",
            "user_created_at" => "User Created At",
            "user_creation_ip" => "User Creation IP",
            "email" => "Email",
            "phone_number" => "Phone Number",
            "birth_date" => "Birth Date",
            "gender" => "Gender",
            "post_url" => "Post URL",
            "timestamp" => "Post Timestamp",
            "caption" => "Caption",
            "comments_count" => "Comment Count",
            "likes_count" => "Like Count",
            "media_uri_1" => "Media URI 1",
            "media_uri_2" => "Media URI 2",
            "hashtag" => "Hashtag",
            "sentiment_analysis" => "Sentiment Analysis",
            "content_type" => "Content Type"
        ];

        parent::__construct();   
    }

    function index() {
        return view('pages.instagram.index')
                ->with('fields', $this->fields);
    }

    function followers_private(Request $request) {
        if (!$request->has('user_id')) {
            return '<p>user_id is required</p>';
        }

        $data = $this->instagram_followers_private
                    ->select('user_name', 'user_link')
                    ->where('user_id', $request->user_id)
                    ->get();

        if ($data->isEmpty()) {
            return '<p>No data found</p>';
        }

        $table = '<table class="display">';
        $table .= '<thead>';
        $table .= '<tr>';
        $table .= '<th>Username</th>';
        $table .= '<th>User Link</th>';
        $table .= '</tr>';
        $table .= '</thead>';

        $table .= '<tbody>';
        foreach ($data as $row) {
            $table .= '<tr>';
            $table .= '<td>'.$row->user_name.'</td>';
            $table .= '<td>'.$row->user_link.'</td>';
            $table .= '</tr>';
        }
        $table .= '</tbody>';
        $table .= '</table>';

        return $table;
    }

    function following_private(Request $request) {
        if (!$request->has('user_id')) {
            return '<p>user_id is required</p>';
        }

        $data = $this->instagram_following_private
                    ->select('user_name', 'user_link')
                    ->where('user_id', $request->user_id)
                    ->get();

        if ($data->isEmpty()) {
            return '<p>No data found</p>';
        }

        $table = '<table class="display">';
        $table .= '<thead>';
        $table .= '<tr>';
        $table .= '<th>Username</th>';
        $table .= '<th>User Link</th>';
        $table .= '</tr>';
        $table .= '</thead>';

        $table .= '<tbody>';
        foreach ($data as $row) {
            $table .= '<tr>';
            $table .= '<td>'.$row->user_name.'</td>';
            $table .= '<td>'.$row->user_link.'</td>';
            $table .= '</tr>';
        }
        $table .= '</tbody>';
        $table .= '</table>';

        return $table;
    }

    function login_history(Request $request) {
        if (!$request->has('user_id')) {
            return '<p>user_id is required</p>';
        }

        $data = $this->instagram_login_history_private
                    ->select('ip_address', 'timestamp')
                    ->where('user_id', $request->user_id)
                    ->get();

        if ($data->isEmpty()) {
            return '<p>No data found</p>';
        }

        $table = '<table class="display">';
        $table .= '<thead>';
        $table .= '<tr>';
        $table .= '<th>IP Address</th>';
        $table .= '<th>Timestamp</th>';
        $table .= '</tr>';

        $table .= '<tbody>';
        foreach ($data as $row) {
            $table .= '<tr>';
            $table .= '<td>'.$row->ip_address.'</td>';
            $table .= '<td>'.Carbon::parse($row->timestamp)->setTimezone('GMT')->format('Y-m-d H:i:s').'</td>';
            $table .= '</tr>';
        }
        $table .= '</tbody>';
        $table .= '</table>';

        return $table;
    }

    function dt() {
        // Get the fields for the datatable response
        $fields = $this->fields;
    
        // Get the public and private data
        $public_data = $this->instagram_public->get()->toArray();
        $private_data = $this->instagram_private->get()->toArray();
    
        // Merge public and private data collection
        $data = collect($public_data)->merge(collect($private_data));
    
        // Order by user_id
        $data = $data->sortBy('user_id');
    
        // Remove user_id from the fields for display purposes
        unset($fields['user_id']);
    
        // Return the data as datatable response
        return datatables()
                ->of($data)
                ->with('fields', $fields)
                ->setTransformer(function($data) use ($fields) {
                    $result = [];
                    foreach ($fields as $key => $value) {
                        if(in_array($key, ['timestamp'])) {
                            if (!empty($data['timestamp_public'])) {
                                $result[$key] = Carbon::parse($data['timestamp_public'])->setTimezone('GMT')->format('Y-m-d H:i:sP');
                            } else if (!empty($data['timestamp_private'])) {
                                $result[$key] = Carbon::parse($data['timestamp_private'])->setTimezone('GMT')->format('Y-m-d H:i:sP');
                            } else {
                                $result[$key] = null;
                            }
                        } else if (in_array($key, ['birth_date', 'user_created_at'])) {
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
                ->rawColumns(['followers', 'following', 'user_creation_ip'])
                ->make(true);
    }
    
}
