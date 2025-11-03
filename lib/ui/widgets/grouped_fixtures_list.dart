import 'package:flutter/material.dart';
import 'package:football_news/core/configs/routes.dart';
import 'package:football_news/core/models/domain/soccer_fixture.dart';
import 'package:football_news/ui/themes/app_colors.dart';
import 'package:football_news/ui/themes/app_fonts.dart';
import 'package:football_news/ui/widgets/fixture_card.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class GroupedFixturesList extends StatelessWidget {
  final List<SoccerFixture> fixtures;
  final bool showLeagueLogo;

  const GroupedFixturesList({
    super.key,
    required this.fixtures,
    this.showLeagueLogo = true,
  });

  @override
  Widget build(BuildContext context) {
    final groupedItems = _buildGroupedFixtures(fixtures);

    return ListView.builder(
      itemCount: groupedItems.length,
      itemBuilder: (context, index) {
        final item = groupedItems[index];
        if (item is String) {
          // Date header
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text(
              item,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeights.semiBold,
                color: AppColors.lightRed,
              ),
            ),
          );
        } else if (item is SoccerFixture) {
          // Fixture card
          final gameTime = item.startTime.toString();
          final localTime = DateTime.parse(gameTime).toUtc();
          final formattedTime = DateFormat('h:mm a').format(localTime);

          return InkWell(
            onTap: () {
              context.push(Routes.fixtureDetails.path, extra: item);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: FixtureCard(
                soccerFixture: item,
                fixtureTime: formattedTime,
                showLeagueLogo: showLeagueLogo,
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  /// Groups fixtures by day and returns a mixed list of [String date headers + fixtures]
  List<dynamic> _buildGroupedFixtures(List<SoccerFixture> fixtures) {
    // Filter out any fixtures missing a startTime
    final validFixtures = fixtures.where((f) => f.startTime != null).toList()
      ..sort((a, b) => a.startTime!.compareTo(b.startTime!));

    final List<dynamic> groupedList = [];
    String? lastDate;

    final now = DateTime.now();

    for (var fixture in validFixtures) {
      final localDate = fixture.startTime!.toUtc();
      final isSameYear = localDate.year == now.year;

      // Example: Sunday, Nov 2 or Sunday, Nov 2, 2025
      final fixtureDate = DateFormat(
        isSameYear ? 'EEEE, MMM d' : 'EEEE, MMM d, yyyy',
      ).format(localDate);

      if (lastDate != fixtureDate) {
        groupedList.add(fixtureDate);
        lastDate = fixtureDate;
      }
      groupedList.add(fixture);
    }

    return groupedList;
  }
}
