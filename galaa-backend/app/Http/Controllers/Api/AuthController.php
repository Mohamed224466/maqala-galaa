<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\AdminUser;

class AuthController extends Controller
{
    /**
     * تسجيل الدخول للمدير.
     */
    public function login(Request $request)
    {
        $credentials = $request->validate([
            'email' => ['required', 'email'],
            'password' => ['required'],
        ]);

        $user = AdminUser::where('email', $credentials['email'])->first();

        if ($user && Auth::guard('admin')->attempt($credentials)) {
            $request->session()->regenerate();
            return response()->json([
                'status' => 'success',
                'message' => 'تم تسجيل الدخول بنجاح',
                'user' => $user,
            ], 200);
        }

        return response()->json([
            'status' => 'error',
            'message' => 'بيانات الدخول غير صحيحة.'
        ], 401);
    }

    /**
     * تسجيل الخروج للمدير.
     */
    public function logout(Request $request)
    {
        Auth::guard('admin')->logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return response()->json(['message' => 'تم تسجيل الخروج بنجاح.'], 200);
    }
}