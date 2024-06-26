<?php

use Illuminate\Support\Facades\Route;

// Import Controller
use App\Http\Controllers\IndexController;
use App\Http\Controllers\TwitterController;
use App\Http\Controllers\InstagramController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::redirect('/', '/dashboard');
Route::get('/dashboard', [IndexController::class, 'index']);

Route::get('/twitter', [TwitterController::class, 'index']) -> name('twitter.index');
Route::get('/instagram', [InstagramController::class, 'index']) -> name('instagram.index');