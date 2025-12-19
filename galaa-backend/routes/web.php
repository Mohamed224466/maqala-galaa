<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ContentController;


/*
|--------------------------------------------------------------------------
| مسارات الـ API (تم وضعها هنا مؤقتاً لسهولة الربط مع React)
|--------------------------------------------------------------------------
*/

// 1. مسار Sanctum/CSRF - (ضروري للربط مع React)
Route::post('/sanctum/csrf-cookie', function (Illuminate\Http\Request $request) {
    return response()->noContent();
});

// 2. مسارات المصادقة (Login / Logout)
Route::controller(AuthController::class)->group(function () {
    Route::post('/login', 'login');
    Route::post('/logout', 'logout')->middleware('auth:admin');
});

// 3. مسارات إدارة المحتوى (تحتاج إلى تسجيل دخول Admin)
Route::middleware('auth:admin')->group(function () {
    // إدارة الأقسام
    Route::controller(ContentController::class)->prefix('categories')->group(function () {
        Route::get('/', 'indexCategories'); // لعرض كل الأقسام
        Route::post('/', 'storeCategory'); // لإضافة قسم جديد
    });
});


use App\Http\Controllers\Api\ProductController; // استيراد الـ Controller الجديد


// ... (مسارات الـ Login/Logout) ...

// مسارات إدارة المحتوى (تحتاج إلى تسجيل دخول Admin)
Route::middleware('auth:admin')->group(function () {
    // إدارة الأقسام
    Route::controller(ContentController::class)->prefix('categories')->group(function () {
        Route::get('/', 'indexCategories'); // لعرض كل الأقسام
        Route::post('/', 'storeCategory'); // لإضافة قسم جديد
    });

    // إدارة المنتجات (Resource Routes) - أضف هذا الجزء
    Route::resource('products', ProductController::class)->except(['create', 'edit']); 

});