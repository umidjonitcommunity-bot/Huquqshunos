// lib/screens/my_bookings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import 'login_screen.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();

    if (!auth.isLoggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Mening buyurtmalarim',
              style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.assignment_outlined, size: 60, color: AppTheme.textGrey.withOpacity(0.4)),
              const SizedBox(height: 16),
              Text('Buyurtmalarni ko\'rish uchun kiring',
                  style: GoogleFonts.inter(color: AppTheme.textGrey)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                ),
                child: const Text('Kirish'),
              ),
            ],
          ),
        ),
      );
    }

    // Demo bookings
    final bookings = [
      ('Alisher Karimov', 'Fuqarolik ishi', '10 Aprel 2025, 10:00', '150,000 so\'m', 'confirmed'),
      ('Malika Yusupova', 'Oila masalasi', '15 Aprel 2025, 14:00', '120,000 so\'m', 'pending'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Mening buyurtmalarim',
            style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold)),
      ),
      body: bookings.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox_outlined, size: 64, color: AppTheme.textGrey.withOpacity(0.4)),
                  const SizedBox(height: 12),
                  Text('Hozircha buyurtmalar yo\'q',
                      style: GoogleFonts.inter(color: AppTheme.textGrey)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: bookings.length,
              itemBuilder: (context, i) {
                final b = bookings[i];
                final isPending = b.$5 == 'pending';
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                b.$1.substring(0, 1),
                                style: GoogleFonts.playfairDisplay(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(b.$1,
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w700, fontSize: 15)),
                                Text(b.$2,
                                    style: GoogleFonts.inter(
                                        color: AppTheme.textGrey, fontSize: 13)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: isPending
                                  ? AppTheme.accent.withOpacity(0.12)
                                  : AppTheme.success.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              isPending ? '⏳ Kutilmoqda' : '✅ Tasdiqlandi',
                              style: GoogleFonts.inter(
                                color: isPending ? AppTheme.accent : AppTheme.success,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(height: 1),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.access_time_outlined,
                              size: 14, color: AppTheme.textGrey),
                          const SizedBox(width: 6),
                          Text(b.$3,
                              style: GoogleFonts.inter(
                                  color: AppTheme.textGrey, fontSize: 12)),
                          const Spacer(),
                          Text(b.$4,
                              style: GoogleFonts.inter(
                                  color: AppTheme.accent,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14)),
                        ],
                      ),
                      if (isPending) ...[
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppTheme.error,
                              side: const BorderSide(color: AppTheme.error),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            child: Text('Bekor qilish',
                                style: GoogleFonts.inter(fontSize: 13)),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
    );
  }
}
