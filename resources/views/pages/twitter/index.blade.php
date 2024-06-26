@extends('layouts.app', ['title' => "Twitter Data"])

@section('content')
<div class="w-full px-6 py-6 mx-auto">
    <div class="flex flex-wrap -mx-3">
        <div class="flex-none w-full max-w-full px-3">
            <div
                class="relative flex flex-col min-w-0 mb-6 break-words bg-white border-0 border-transparent border-solid shadow-soft-xl rounded-2xl bg-clip-border">
                <div class="p-6 pb-0 mb-0 bg-white border-b-0 border-b-solid rounded-t-2xl border-b-transparent">
                    <h6>
                        Twitter Data
                    </h6>
                </div>
                <div class="flex-auto px-0 pt-0 pb-2">
                    <div class="p-6 table-responsive">
                        <table class="display compact" id="table_data"></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

@push('configurator')
<div fixed-plugin>
    <a fixed-plugin-button
        class="bottom-7.5 right-7.5 text-xl z-990 shadow-soft-lg rounded-circle fixed cursor-pointer bg-white px-4 py-2 text-slate-700">
        <i class="py-2 pointer-events-none fa fa-cog"> </i>
    </a>
    <!-- -right-90 in loc de 0-->
    <div fixed-plugin-card
        class="z-sticky shadow-soft-3xl w-90 ease-soft -right-90 fixed top-0 left-auto flex h-full min-w-0 flex-col break-words rounded-none border-0 bg-white bg-clip-border px-2.5 duration-200">
        <div class="px-6 pt-4 pb-0 mb-0 bg-white border-b-0 rounded-t-2xl">
            <div class="float-left">
                <h5 class="mt-4 mb-0">Twitter Configurator</h5>
            </div>
            <div class="float-right mt-6">
                <button fixed-plugin-close-button
                    class="inline-block p-0 mb-4 font-bold text-center uppercase align-middle transition-all bg-transparent border-0 rounded-lg shadow-none cursor-pointer hover:scale-102 leading-pro text-xs ease-soft-in tracking-tight-soft bg-150 bg-x-25 active:opacity-85 text-slate-700">
                    <i class="fa fa-close"></i>
                </button>
            </div>
            <!-- End Toggle Button -->
        </div>
        <hr class="h-px mx-0 my-1 bg-transparent bg-gradient-to-r from-transparent via-black/40 to-transparent" />
        <div class="flex-auto p-6 pt-0 sm:pt-4 overflow-y-auto">
            <!-- Sidebar Backgrounds -->
            <div>
                <h6 class="mb-0">Column Visibility</h6>
            </div>
            
            <form id="ColumnVisibilitySettingsForm">
                @foreach ($fields as $fields_key => $fields_value)
                    <div onclick="checkTheBox('{{$fields_key}}')" class="column_visibility_option cursor-pointer {{$fields_key}}">
                        <div class="border p-1 px-2 cursor-pointer my-1">
                            <input onchange="set_active_fields('{{$fields_key}}')" type="checkbox" class="checkbox_{{$fields_key}}" name="fields[{{$fields_key}}]" id="{{$fields_key}}">
                            <label class="label" for="{{$fields_key}}">{{$fields_value}}</label>
                        </div>
                    </div>
                @endforeach
            </form>
        </div>
    </div>
</div>
@endpush

@push('modal')
<div id="table_modal" class="modal"></div>
@endpush

@push('css')
    <style>
        .modal {
            max-width: 650px;
        }
        .table-responsive {
            overflow-x: auto;
            width: 100%;
        }
        #table_data {
            width: 100%;
            max-width: 100%;
        }
    </style>
@endpush

@push('js')
    <script>
        const FIELDS = @json($fields);
        const FIELDS_KEYS = Object.keys(FIELDS);
        const SAVED_ACTIVE_FIELDS_NAME = 'twitter_active_fields';

        const DT_API_PATH = '{{route("twitter.dt")}}'
        const FOLLOWERS_API_PATH = '{{route("twitter.followers-private")}}'
        const FOLLOWING_API_PATH = '{{route("twitter.following-private")}}'
        const IP_AUDIT_API_PATH = '{{route("twitter.ip-audit")}}'

        $(function () {
            load_data()
        });

        function followers_modal(user_id) {
            $.ajax({
                url: FOLLOWERS_API_PATH + '?user_id=' + user_id,
                success: function (response) {
                    $('#table_modal').html(response);
                    new DataTable('#table_modal table');
                    $('#table_modal').modal('show');   
                },
                error: function (error) {
                    console.log(error)
                }
            });
        }

        function following_modal(user_id) {
            $.ajax({
                url: FOLLOWING_API_PATH + '?user_id=' + user_id,
                success: function (response) {
                    $('#table_modal').html(response);
                    new DataTable('#table_modal table');
                    $('#table_modal').modal('show');   
                },
                error: function (error) {
                    console.log(error)
                }
            });
        }

        function ip_modal(user_id) {
            $.ajax({
                url: IP_AUDIT_API_PATH + '?user_id=' + user_id,
                success: function (response) {
                    $('#table_modal').html(response);
                    new DataTable('#table_modal table');
                    $('#table_modal').modal('show');   
                },
                error: function (error) {
                    console.log(error)
                }
            });
        }

        function load_data() {
            var columns = [];

            // Get active fields value from FIELDS object
            for (let index = 0; index < FIELDS_KEYS.length; index++) {
                columns.push({
                    data: FIELDS_KEYS[index],
                    name: FIELDS_KEYS[index],
                    title: FIELDS[FIELDS_KEYS[index]]
                })
            }

            // return the datatable
            return $('#table_data').DataTable({
                processing: true,
                serverSide: true,
                destroy: true,
                ajax: {
                    url: DT_API_PATH,
                },
                columns: columns,
                stateSave: true,
                colReorder: true,
                pageLength: 20,
                order: [], // Disable initial sorting
                layout: {
                    topStart: {
                        buttons: ['colvis', 'excel', 'print', 'pageLength']
                    }
                }
            });
        }
    </script>
@endpush