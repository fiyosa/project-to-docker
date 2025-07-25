<?php

namespace App\Jobs;

use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;
use Illuminate\Support\Facades\Log;
use romanzipp\QueueMonitor\Traits\IsMonitored;

class TestJob implements ShouldQueue
{
    use Queueable, IsMonitored;

    /**
     * Create a new job instance.
     */
    public function __construct(protected $data, protected $shouldFail = false)
    {
        //
    }

    /**
     * Execute the job.
     */
    public function handle(): void
    {
        // sleep(7);
        // Simulasi job gagal jika shouldFail true
        // if ($this->shouldFail) {
        //     throw new \Exception('Simulasi: Job sengaja dibuat gagal!');
        // }

        info('start job');

        // Atau bisa juga simulasi gagal secara acak
        if (rand(0, 1) && !$this->shouldFail) {
            throw new \Exception('Simulasi: Job gagal secara acak!');
        }

        // if (true) {
        //     throw new \RuntimeException('Simulasi: Job gagal secara acak!');
        // }

        info(json_encode($this->data));
    }

    public function failed($exception): void
    {
        Log::error('anjay');
    }
}
