<li class="mt-0.5 w-full">
    <a class="{{ request()->is('dashboard') ? 'shadow-soft-xl rounded-lg bg-white' : '' }} py-2.7 text-sm ease-nav-brand my-0 mx-4 flex items-center whitespace-nowrap px-4 text-slate-700 transition-colors" href="{{ url('/') }}">
        <div class="{{ request()->is('dashboard') ? 'bg-gradient-to-tl from-blue-600 to-cyan-400 text-white' : '' }} shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2.5">
            <i class="fas fa-tachometer-alt"></i>
        </div>
        <span class="ml-1 duration-300 opacity-100 pointer-events-none ease-soft {{ request()->is('dashboard') ? 'font-semibold' : '' }}">
            Dashboard
        </span>
    </a>
</li>

<li class="mt-0.5 w-full">
    <a class="{{ request()->is('twitter') ? 'shadow-soft-xl rounded-lg bg-white' : '' }} py-2.7 text-sm ease-nav-brand my-0 mx-4 flex items-center whitespace-nowrap px-4 text-slate-700 transition-colors" href="{{ route('twitter.index') }}">
        <div class="{{ request()->is('twitter') ? 'bg-gradient-to-tl from-gray-900 to-slate-800 text-white' : '' }} shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2.5">
            <i class="fab fa-x-twitter"></i>
        </div>
        <span class="ml-1 duration-300 opacity-100 pointer-events-none ease-soft {{ request()->is('twitter') ? 'font-semibold' : '' }}">Twitter</span>
    </a>
</li>

<li class="mt-0.5 w-full">
    <a class="{{ request()->is('instagram') ? 'shadow-soft-xl rounded-lg bg-white' : '' }} py-2.7 text-sm ease-nav-brand my-0 mx-4 flex items-center whitespace-nowrap px-4 text-slate-700 transition-colors" href="{{ route('instagram.index') }}">
        <div class="{{ request()->is('instagram') ? 'bg-gradient-to-tl from-purple-700 to-pink-500 text-white' : '' }} shadow-soft-2xl mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-white bg-center stroke-0 text-center xl:p-2.5">
            <i class="fab fa-instagram"></i>
        </div>
        <span class="ml-1 duration-300 opacity-100 pointer-events-none ease-soft {{ request()->is('instagram') ? 'font-semibold' : '' }}">Instagram</span>
    </a>
</li>
