<?php

use App\Jobs\TestJob;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::get('/test/log', function () {
    info('Log info');
    return response()->json(['message' => 'success']);
});

Route::get('/test/job', function () {
    TestJob::dispatch([
        'foo' => 'bar',
    ]);
    return response()->json(['message' => 'success']);
});
