import React, { useState } from 'react';
import axios from 'axios';

// 🛑 تأكد من أن ملف .env موجود ويحتوي على: VITE_API_URL=http://127.0.0.1:8000
const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8000'; 

// تحديد الإعدادات الهامة للـ Backend
axios.defaults.withCredentials = true; 

function App() {
    // استخدم بياناتك الصحيحة هنا
    const [email, setEmail] = useState('mo6988676@gmail.com');
    const [password, setPassword] = useState('كلمة المرور الحقيقية هنا'); // *استبدلها بكلمة المرور*
    const [message, setMessage] = useState('');
    const [loading, setLoading] = useState(false);

    const handleLogin = async (e) => {
        e.preventDefault();
        setMessage('');
        setLoading(true);

        try {
            // 1. طلب CSRF Cookie
            await axios.post(`${API_URL}/sanctum/csrf-cookie`);
            
            // 2. طلب تسجيل الدخول الفعلي
            const response = await axios.post(`${API_URL}/login`, {
                email,
                password
            });

            if (response.status === 200 && response.data.status === 'success') {
                setMessage(`✅ نجاح التسجيل! مرحباً بك يا ${response.data.user.name}. الربط سليم!`);
            } else {
                setMessage('❌ فشل في التسجيل: بيانات غير صحيحة.');
            }

        } catch (error) {
            console.error("API Error:", error);
            if (error.response) {
                if (error.response.status === 401) {
                    setMessage('❌ فشل التسجيل: بيانات الدخول غير صحيحة (401).');
                } else {
                    setMessage(`❌ خطأ في السيرفر: ${error.response.status}.`);
                }
            } else {
                setMessage('❌ فشل الاتصال. تأكد أن سيرفر Laravel يعمل وسيرفر React يعمل.');
            }
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={{ padding: '20px', fontFamily: 'Arial, sans-serif', direction: 'rtl', textAlign: 'right' }}>
            
            {/* 🛑 تم تغيير النص لتجنب المشكلة */}
            <h2>اختبار تسجيل الدخول (React يتواصل مع Laravel)</h2> 
            
            <p><strong>العنوان المستخدم:</strong> {API_URL}</p>
            <form onSubmit={handleLogin} style={{ display: 'flex', flexDirection: 'column', gap: '10px', maxWidth: '350px' }}>
                <input
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    placeholder="البريد الإلكتروني"
                    style={{ padding: '10px', border: '1px solid #ccc' }}
                    required
                />
                <input
                    type="password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    placeholder="كلمة المرور"
                    style={{ padding: '10px', border: '1px solid #ccc' }}
                    required
                />
                <button 
                    type="submit" 
                    disabled={loading}
                    style={{ padding: '10px', backgroundColor: loading ? '#ccc' : '#007bff', color: 'white', border: 'none', cursor: loading ? 'not-allowed' : 'pointer' }}
                >
                    {loading ? 'جاري التحقق...' : 'تسجيل الدخول'}
                </button>
            </form>
            <p style={{ marginTop: '20px', fontWeight: 'bold', color: message.startsWith('✅') ? 'green' : 'red' }}>{message}</p>
        </div>
    );
}

export default App;