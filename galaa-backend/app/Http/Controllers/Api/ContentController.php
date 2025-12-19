<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Category;

class ContentController extends Controller
{
    /**
     * عرض جميع الأقسام.
     */
    public function indexCategories()
    {
        $categories = Category::all();
        return response()->json($categories, 200);
    }

    /**
     * إنشاء قسم جديد.
     */
    public function storeCategory(Request $request)
    {
        $validatedData = $request->validate([
            'name_ar' => 'required|string|max:255|unique:categories,name_ar',
            'slug' => 'required|string|max:255|unique:categories,slug',
            'description_ar' => 'nullable|string',
        ]);

        $category = Category::create($validatedData);

        return response()->json([
            'message' => 'تم إنشاء القسم بنجاح',
            'category' => $category
        ], 201);
    }

    // هنا سيتم إضافة دوال التعديل والحذف والمنتجات لاحقاً
}