import 'package:flutter/material.dart';
import 'package:football_news/core/configs/routes.dart';
import 'package:football_news/core/backups/matches_controller.dart';
import 'package:football_news/core/backups/fixture_card.dart';
import 'package:football_news/ui/widgets/leagues_list.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LiveScore extends StatelessWidget {
  const LiveScore({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MatchesController>();

    return CustomScrollView(
      slivers: [
        // League selector
        const SliverToBoxAdapter(child: LeaguesList()),

        // “Fixtures” header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.calendar_month, size: 18, color: Colors.blue),
                    SizedBox(width: 6),
                    Text(
                      'Fixtures',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => context.go(Routes.fixtures.path),
                  child: Row(
                    spacing: 4,
                    children: [
                      Text('View All'),
                      Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // ✅ Fixtures list (its own sliver)
        Obx(() {
          final matches = controller.items;
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => FixtureCard(match: matches[index]),
              childCount: matches.length,
            ),
          );
        }),
      ],
    );
  }
}
