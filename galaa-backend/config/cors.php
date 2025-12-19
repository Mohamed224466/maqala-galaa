<?php

return [

    // مسارات الـ API المسموح بها
    'paths' => ['api/*', 'sanctum/csrf-cookie', 'login', 'logout', 'categories/*', 'products/*'],

    'allowed_methods' => [
        'GET',
        'POST',
        'PUT',
        'PATCH',
        'DELETE',
        'OPTIONS',
    ],

    // نطاق الـ Frontend الخاص بك (يقرأ من ملف .env)
    'allowed_origins' => [env('FRONTEND_URL', 'http://localhost:5173')], 

    'allowed_origins_patterns' => [],

    'allowed_headers' => ['*'],

    'exposed_headers' => [],

    // 🛑 يجب أن يكون TRUE: للسماح بتبادل الـ Cookies (Sanctum)
    'supports_credentials' => true, 

    'max_age' => 3600,

];