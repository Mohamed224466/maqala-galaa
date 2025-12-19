<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    protected $table = 'products';
    
    // الحقول المسموح بتعديلها في جدول المنتجات
    protected $fillable = [
        'category_id',
        'name_ar',
        'slug',
        'description_ar',
        'price',
        'discount_price',
        'is_available',
        'image',
        'product_type', // مثل مقلي/سوبر ماركت
    ];

    /**
     * تعريف العلاقة: المنتج ينتمي لقسم واحد.
     */
    public function category()
    {
        return $this->belongsTo(Category::class);
    }
}