// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth_service.dart';
import '../services/locale_service.dart';
import '../services/theme_service.dart';
import '../models/user_model.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'lawyer_dashboard_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    final locale = context.watch<LocaleService>();

    if (!auth.isLoggedIn) {
      return _buildGuestView(context);
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: AppTheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.primary, Color(0xFF0F2340)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppTheme.accent,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Center(
                            child: Text(
                              auth.currentUser!.fullName.substring(0, 1).toUpperCase(),
                              style: GoogleFonts.playfairDisplay(
                                color: Colors.white,
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          auth.currentUser!.fullName,
                          style: GoogleFonts.playfairDisplay(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: auth.isLawyer
                                ? AppTheme.accent.withOpacity(0.3)
                                : Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            auth.isLawyer ? '⚖️ Yurist' : '👤 Mijoz',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info card
                  _infoCard([
                    _infoRow(Icons.email_outlined, 'Elektron pochta', auth.currentUser!.email),
                    _divider(),
                    _infoRow(Icons.phone_outlined, 'Telefon', auth.currentUser!.phone),
                  ]),

                  const SizedBox(height: 16),

                  // Lawyer dashboard shortcut
                  if (auth.isLawyer) ...[
                    _menuCard([
                      _menuItem(
                        context,
                        Icons.dashboard_outlined,
                        'Yurist paneli',
                        'Xizmatlar va buyurtmalar',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LawyerDashboardScreen()),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 16),
                  ],

                  // Language selection
                  _menuCard([
                    _menuItemWithTrailing(
                      context,
                      Icons.language_outlined,
                      'Til',
                      locale.languageName,
                      onTap: () => _showLanguageDialog(context, locale),
                    ),
                  ]),

                  const SizedBox(height: 16),

                  // Settings
                  _menuCard([
                    _menuItem(
                      context,
                      Icons.notifications_outlined,
                      'Bildirishnomalar',
                      'Push-xabarlar sozlamalari',
                    ),
                    _divider(),
                    _menuItem(
                      context,
                      Icons.security_outlined,
                      'Xavfsizlik',
                      'Parolni o\'zgartirish',
                    ),
                    _divider(),
                    _menuItem(
                      context,
                      Icons.help_outline,
                      'Yordam',
                      'Ko\'p beriladigan savollar',
                    ),
                  ]),

                  const SizedBox(height: 16),

                  // Logout
                  _menuCard([
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.logout_rounded, color: AppTheme.error, size: 20),
                      ),
                      title: Text(
                        'Chiqish',
                        style: GoogleFonts.inter(
                          color: AppTheme.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            title: Text('Chiqish',
                                style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold)),
                            content: Text('Hisobdan chiqishni xohlaysizmi?',
                                style: GoogleFonts.inter()),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Bekor qilish'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  auth.logout();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.error),
                                child: const Text('Chiqish'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ]),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuestView(BuildContext context) {
    final locale = context.watch<LocaleService>();
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text('Profil', style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.language_outlined),
            onPressed: () => _showLanguageDialog(context, locale),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Icon(Icons.person_outline, size: 50, color: AppTheme.primary),
              ),
              const SizedBox(height: 20),
              Text(
                'Hisobingizga kiring',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Buyurtma berish va tarixni ko\'rish uchun kiring',
                style: GoogleFonts.inter(color: AppTheme.textGrey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  ),
                  child: const Text('Kirish'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  ),
                  child: const Text("Ro'yxatdan o'tish"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, LocaleService locale) {
    final langs = [
      (const Locale('uz'), "🇺🇿  O'zbek"),
      (const Locale('ru'), '🇷🇺  Русский'),
      (const Locale('en'), '🇬🇧  English'),
    ];
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Til tanlang', style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: langs.map((lang) => ListTile(
            title: Text(lang.$2, style: GoogleFonts.inter()),
            trailing: locale.locale == lang.$1
                ? Icon(Icons.check_circle, color: AppTheme.primary)
                : null,
            onTap: () {
              locale.setLocale(lang.$1);
              Navigator.pop(context);
            },
          )).toList(),
        ),
      ),
    );
  }

  Widget _infoCard(List<Widget> children) => Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: Column(children: children),
      );

  Widget _menuCard(List<Widget> children) => Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: Column(children: children),
      );

  Widget _infoRow(IconData icon, String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primary, size: 20),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: GoogleFonts.inter(color: AppTheme.textGrey, fontSize: 11)),
                Text(value,
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14)),
              ],
            ),
          ],
        ),
      );

  Widget _menuItem(BuildContext context, IconData icon, String title, String subtitle,
      {VoidCallback? onTap}) =>
      ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppTheme.primary, size: 20),
        ),
        title: Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textGrey)),
        trailing: const Icon(Icons.chevron_right, color: AppTheme.textGrey),
        onTap: onTap ?? () {},
      );

  Widget _menuItemWithTrailing(BuildContext context, IconData icon, String title, String trailing,
      {VoidCallback? onTap}) =>
      ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppTheme.primary, size: 20),
        ),
        title: Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(trailing, style: GoogleFonts.inter(color: AppTheme.textGrey, fontSize: 13)),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right, color: AppTheme.textGrey),
          ],
        ),
        onTap: onTap ?? () {},
      );

  Widget _divider() => const Divider(height: 1, indent: 56);
}
