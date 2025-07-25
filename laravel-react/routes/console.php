<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');

Artisan::command('boost:clear', function () {
    $this->info('Clearing all caches...');

    $this->call('clear-compiled');
    $this->call('route:clear');
    $this->call('config:clear');
    $this->call('view:clear');
    $this->call('event:clear');

    $this->newLine();
    $this->info('All caches cleared successfully!');
})->purpose('Clear all cached and optimized files');

Artisan::command('boost:create', function () {
    $this->info('Create caches...');

    $this->call('route:cache');
    $this->call('config:cache');
    $this->call('view:cache');
    $this->call('event:cache');

    $this->newLine();
    $this->info('All caches created successfully!');
})->purpose('Create cached');

Artisan::command('boost', function () {
    $this->call('boost:clear');
    $this->call('boost:create');
})->purpose('Create cached and optimized files');
