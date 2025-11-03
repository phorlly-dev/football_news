import 'package:flutter/material.dart';
import 'package:football_news/core/backups/matches.dart';
import 'package:football_news/core/utils/app_strings.dart';
import 'package:football_news/core/extensions/nums.dart';
import 'package:football_news/core/utils/utils.dart';
import 'package:football_news/ui/components/custom_image.dart';
import 'package:football_news/ui/themes/app_colors.dart';

class FixtureCard extends StatelessWidget {
  final Matches match;
  const FixtureCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Utils.dateToTime(match.time),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 6),
            Text(match.leagueName, style: TextStyle(color: Colors.grey[600])),
            Text(
              'Round ${match.round}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _TeamWidget(name: match.homeTeam, logo: match.homeLogo),
                const Text(AppStrings.vs),
                _TeamWidget(name: match.awayTeam, logo: match.awayLogo),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Scheduled',
                style: TextStyle(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamWidget extends StatelessWidget {
  final String name;
  final String logo;
  const _TeamWidget({required this.name, required this.logo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.white,
          radius: 16.radius,
          child: CustomImage(
            imageUrl: logo,
            width: 26.radius,
            height: 26.radius,
          ),
        ),
        const SizedBox(height: 6),
        Text(name, style: const TextStyle(fontWeight: FontWeight.w400)),
      ],
    );
  }
}
