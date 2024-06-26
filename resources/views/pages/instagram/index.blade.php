@extends('layouts.app', ['title' => "Instagram Data"])

@section('content')
<div class="w-full px-6 py-6 mx-auto">
    <div class="flex flex-wrap -mx-3">
        <div class="flex-none w-full max-w-full px-3">
            <div
                class="relative flex flex-col min-w-0 mb-6 break-words bg-white border-0 border-transparent border-solid shadow-soft-xl rounded-2xl bg-clip-border">
                <div class="p-6 pb-0 mb-0 bg-white border-b-0 border-b-solid rounded-t-2xl border-b-transparent">
                    <h6>
                        Instagram Data
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
        const SAVED_ACTIVE_FIELDS_NAME = 'instagram_active_fields';

        const DT_API_PATH = '{{route("instagram.dt")}}'
        const FOLLOWERS_API_PATH = '{{route("instagram.followers-private")}}'
        const FOLLOWING_API_PATH = '{{route("instagram.following-private")}}'
        const LOGIN_HISTORY_API_PATH = '{{route("instagram.login-history")}}'

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
                url: LOGIN_HISTORY_API_PATH + '?user_id=' + user_id,
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
                pageLength: 20,
                colReorder: true,
                saveState: true,
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