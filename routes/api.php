<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\DB;

// Import Controller
use App\Http\Controllers\TwitterController;
use App\Http\Controllers\InstagramController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// Twitter API
Route::get('/twitter/dt', [TwitterController::class, 'dt'])->name('twitter.dt');
Route::get('/twitter/followers-private', [TwitterController::class, 'followers_private'])->name('twitter.followers-private');
Route::get('/twitter/following-private', [TwitterController::class, 'following_private'])->name('twitter.following-private');
Route::get('/twitter/ip-audit', [TwitterController::class, 'ip_audit'])->name('twitter.ip-audit');

// Instagram API
Route::get('/instagram/dt', [InstagramController::class, 'dt'])->name('instagram.dt');
Route::get('/instagram/followers-private', [InstagramController::class, 'followers_private'])->name('instagram.followers-private');
Route::get('/instagram/following-private', [InstagramController::class, 'following_private'])->name('instagram.following-private');
Route::get('/instagram/login-history', [InstagramController::class, 'login_history'])->name('instagram.login-history');