// lib/widgets/lawyer_card.dart
import 'package:flutter/material.dart';
import '../models/lawyer_model.dart';
import '../services/theme_service.dart';
import 'package:google_fonts/google_fonts.dart';

class LawyerCard extends StatelessWidget {
  final LawyerModel lawyer;
  final VoidCallback onTap;

  const LawyerCard({super.key, required this.lawyer, required this.onTap});

  String _getSpecializationLabel(String spec, BuildContext context) {
    const map = {
      'civilLaw': 'Fuqarolik huquqi',
      'criminalLaw': 'Jinoyat huquqi',
      'familyLaw': 'Oilaviy huquq',
      'businessLaw': 'Biznes huquqi',
      'laborLaw': 'Mehnat huquqi',
      'realEstateLaw': "Ko'chmas mulk",
    };
    return map[spec] ?? spec;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 15,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.primary, AppTheme.primaryLight],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: lawyer.photoUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(lawyer.photoUrl!, fit: BoxFit.cover),
                      )
                    : Center(
                        child: Text(
                          lawyer.fullName.substring(0, 1),
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
              const SizedBox(width: 14),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            lawyer.fullName,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textDark,
                            ),
                          ),
                        ),
                        if (lawyer.isVerified)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppTheme.success.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.verified, size: 12, color: AppTheme.success),
                                const SizedBox(width: 3),
                                Text(
                                  'Tasdiqlangan',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    color: AppTheme.success,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _getSpecializationLabel(lawyer.specialization, context),
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star_rounded, size: 16, color: AppTheme.accent),
                        const SizedBox(width: 3),
                        Text(
                          lawyer.rating.toStringAsFixed(1),
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textDark,
                          ),
                        ),
                        Text(
                          ' (${lawyer.reviewCount})',
                          style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textGrey),
                        ),
                        const Spacer(),
                        Text(
                          '${(lawyer.pricePerConsultation / 1000).toStringAsFixed(0)}K so\'m',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.accent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.work_outline, size: 13, color: AppTheme.textGrey),
                        const SizedBox(width: 4),
                        Text(
                          '${lawyer.experienceYears} yil tajriba',
                          style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textGrey),
                        ),
                        const Spacer(),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: lawyer.isAvailable ? AppTheme.success : AppTheme.textGrey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          lawyer.isAvailable ? 'Bo\'sh' : 'Band',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: lawyer.isAvailable ? AppTheme.success : AppTheme.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
