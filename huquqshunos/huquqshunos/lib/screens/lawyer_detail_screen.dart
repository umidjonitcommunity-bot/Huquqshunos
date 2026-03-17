// lib/screens/lawyer_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/lawyer_model.dart';
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import 'login_screen.dart';
import 'booking_screen.dart';

class LawyerDetailScreen extends StatelessWidget {
  final LawyerModel lawyer;
  const LawyerDetailScreen({super.key, required this.lawyer});

  String _getSpecializationLabel(String spec) {
    const map = {
      'civilLaw': 'Fuqarolik huquqi',
      'criminalLaw': 'Jinoyat huquqi',
      'familyLaw': 'Oilaviy huquq',
      'businessLaw': 'Biznes huquqi',
      'laborLaw': 'Mehnat huquqi',
      'realEstateLaw': "Ko'chmas mulk huquqi",
    };
    return map[spec] ?? spec;
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: AppTheme.accent,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white30, width: 2),
                        ),
                        child: Center(
                          child: Text(
                            lawyer.fullName.substring(0, 1),
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        lawyer.fullName,
                        style: GoogleFonts.playfairDisplay(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _getSpecializationLabel(lawyer.specialization),
                        style: GoogleFonts.inter(
                          color: AppTheme.accentLight,
                          fontSize: 13,
                        ),
                      ),
                    ],
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
                  // Stats row
                  Row(
                    children: [
                      _statCard('⭐ ${lawyer.rating}', 'Reyting'),
                      const SizedBox(width: 12),
                      _statCard('${lawyer.reviewCount}', 'Sharhlar'),
                      const SizedBox(width: 12),
                      _statCard('${lawyer.experienceYears} yil', 'Tajriba'),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Price
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.accent.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.payments_outlined, color: AppTheme.accent),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Konsultatsiya narxi',
                              style: GoogleFonts.inter(color: AppTheme.textGrey, fontSize: 12),
                            ),
                            Text(
                              '${lawyer.pricePerConsultation.toStringAsFixed(0)} so\'m',
                              style: GoogleFonts.playfairDisplay(
                                color: AppTheme.accent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: lawyer.isAvailable
                                ? AppTheme.success.withOpacity(0.1)
                                : AppTheme.textGrey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            lawyer.isAvailable ? '🟢 Bo\'sh' : '🔴 Band',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: lawyer.isAvailable ? AppTheme.success : AppTheme.textGrey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // About
                  _sectionTitle('Men haqimda'),
                  const SizedBox(height: 8),
                  Text(
                    lawyer.aboutMe,
                    style: GoogleFonts.inter(color: AppTheme.textDark, height: 1.6),
                  ),
                  const SizedBox(height: 16),

                  // Education
                  _sectionTitle('Ta\'lim'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.school_outlined, color: AppTheme.primary, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          lawyer.education,
                          style: GoogleFonts.inter(color: AppTheme.textDark),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Contact
                  _sectionTitle('Aloqa'),
                  const SizedBox(height: 8),
                  _contactRow(Icons.email_outlined, lawyer.email),
                  const SizedBox(height: 6),
                  _contactRow(Icons.phone_outlined, lawyer.phone),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: lawyer.isAvailable
              ? () {
                  if (!auth.isLoggedIn) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookingScreen(lawyer: lawyer),
                      ),
                    );
                  }
                }
              : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: AppTheme.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: Text(
            lawyer.isAvailable ? '📅 Buyurtma berish' : 'Hozir band',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _statCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
            )
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppTheme.primary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textGrey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) => Text(
        title,
        style: GoogleFonts.playfairDisplay(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: AppTheme.textDark,
        ),
      );

  Widget _contactRow(IconData icon, String value) => Row(
        children: [
          Icon(icon, size: 16, color: AppTheme.textGrey),
          const SizedBox(width: 8),
          Text(value, style: GoogleFonts.inter(color: AppTheme.textDark, fontSize: 14)),
        ],
      );
}
