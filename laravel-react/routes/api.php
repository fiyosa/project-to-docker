<?php

use App\Jobs\TestJob;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Storage;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::get('/test/log', function () {
    info('Log info');
    return response()->json(['message' => 'success']);
});

Route::get('/test/job', function () {
    TestJob::dispatch([
        'foo' => rand(1, 1000),
    ], false);
    return response()->json(['message' => 'success']);
});

Route::get('/test/s3', function () {
    // $contents = Storage::disk('s3')->get('test/landscape.jpg');
    // $contents = Storage::url('portrait.jpg');
    // $file = Storage::get('portrait.jpg');

    $file = Storage::disk('s3')->get('test/portrait.jpg');
    $mimeType = Storage::mimeType('test/landscape.jpg') ?? 'application/octet-stream';
    return response($file, 200)->header('Content-Type', $mimeType);

    // $contents = Storage::url('portrait.jpg');
    // return response()->json(['message' => $contents]);
});

Route::get('/test/s3/put', function () {
    $localFilePath = 'I:z_kerja/PT-Sigma-Telkom/work/dummy/portrait.jpg'; // Path file di local storage
    $s3FilePath = 'test/portrait.jpg';      // Path tujuan di S3/Garage

    // Cek apakah file ada di local
    if (!file_exists($localFilePath)) { // Gunakan file_exists untuk path absolut
        return response()->json(['error' => 'File lokal tidak ditemukan'], 404);
    }

    try {
        // Baca file dari local
        $fileContent = file_get_contents($localFilePath);

        // Upload ke S3/Garage
        Storage::disk('s3')->put($s3FilePath, $fileContent);

        return response()->json([
            'message' => 'File berhasil diupload ke S3',
            'path' => $s3FilePath,
        ]);
    } catch (\Exception $e) {
        return response()->json([
            'error' => 'Upload gagal',
            'message' => $e->getMessage()
        ], 500);
    }
});

Route::get('/test/s3/delete', function () {
    $s3FilePath = 'test/portrait.jpg';      // Path tujuan di S3/Garage

    try {
        // Upload ke S3/Garage
        Storage::disk('s3')->delete($s3FilePath);

        return response()->json([
            'message' => 'File berhasil dihapus',
        ]);
    } catch (\Exception $e) {
        return response()->json([
            'error' => 'delete gagal',
            'message' => $e->getMessage()
        ], 500);
    }
});
