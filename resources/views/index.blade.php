@extends('layouts.app', ['title' => "Dashboard"])

@section('content')
<!-- cards -->
<div class="w-full px-6 py-6 mx-auto">
  <!-- row 1 -->
  <div class="flex flex-wrap -mx-3">
    <!-- card1 -->
    <div class="w-full max-w-full px-3 mb-6 sm:w-1/2 sm:flex-none xl:mb-0 xl:w-1/4">
  <div class="relative flex flex-col min-w-0 break-words bg-white shadow-soft-xl rounded-2xl bg-clip-border">
    <div class="flex-auto p-4">
      <div class="flex flex-row items-center justify-between -mx-3">
        <div class="flex-none w-2/3 max-w-full px-3">
          <div>
            <p class="mb-0 font-sans text-sm leading-normal">
              Public Twitter Tweets
            </p>
            <h5 class="mb-0 font-bold">
              {{ $twitter_public_total }}
            </h5>
          </div>
        </div>
        <div class="flex-none px-3">
          <div class="inline-block w-12 h-12 rounded-lg bg-gradient-to-tl from-gray-900 to-slate-800 flex items-center justify-center">
            <i class="fab fa-x-twitter text-lg text-white"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


    <!-- card2 -->
    <div class="w-full max-w-full px-3 mb-6 sm:w-1/2 sm:flex-none xl:mb-0 xl:w-1/4">
  <div class="relative flex flex-col min-w-0 break-words bg-white shadow-soft-xl rounded-2xl bg-clip-border">
    <div class="flex-auto p-4">
      <div class="flex flex-row items-center justify-between -mx-3">
        <div class="flex-none w-2/3 max-w-full px-3">
          <div>
            <p class="mb-0 font-sans text-sm leading-normal">
              Private Twitter Tweets
            </p>
            <h5 class="mb-0 font-bold">
              {{ $twitter_private_total }}
            </h5>
          </div>
        </div>
        <div class="flex-none px-3">
          <div class="inline-block w-12 h-12 rounded-lg bg-gradient-to-tl from-gray-900 to-slate-800 flex items-center justify-center">
            <i class="fab fa-x-twitter text-lg text-white"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


    <!-- card3 -->
    <div class="w-full max-w-full px-3 mb-6 sm:w-1/2 sm:flex-none xl:mb-0 xl:w-1/4">
  <div class="relative flex flex-col min-w-0 break-words bg-white shadow-soft-xl rounded-2xl bg-clip-border">
    <div class="flex-auto p-4">
      <div class="flex flex-row items-center justify-between -mx-3">
        <div class="flex-none w-2/3 max-w-full px-3">
          <div>
            <p class="mb-0 font-sans text-sm leading-normal">
              Public Instagram Posts
            </p>
            <h5 class="mb-0 font-bold">
              {{ $instagram_public_total }}
            </h5>
          </div>
        </div>
        <div class="flex-none px-3">
          <div class="inline-block w-12 h-12 rounded-lg bg-gradient-to-tl from-purple-700 to-pink-500 flex items-center justify-center">
            <i class="fab fa-instagram text-lg text-white"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


    <!-- card4 -->
    <div class="w-full max-w-full px-3 sm:w-1/2 sm:flex-none xl:w-1/4">
  <div class="relative flex flex-col min-w-0 break-words bg-white shadow-soft-xl rounded-2xl bg-clip-border">
    <div class="flex-auto p-4">
      <div class="flex flex-row items-center justify-between -mx-3">
        <div class="flex-none w-2/3 max-w-full px-3">
          <div>
            <p class="mb-0 font-sans text-sm leading-normal">
              Private Instagram Posts
            </p>
            <h5 class="mb-0 font-bold">
              {{ $instagram_private_total }}
            </h5>
          </div>
        </div>
        <div class="flex-none px-3">
          <div class="inline-block w-12 h-12 rounded-lg bg-gradient-to-tl from-purple-700 to-pink-500 flex items-center justify-center">
            <i class="fab fa-instagram text-lg text-white"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


  </div>
  @endsection