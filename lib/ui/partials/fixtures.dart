import 'package:flutter/material.dart';
import 'package:football_news/core/controllers/fixture_controller.dart';
import 'package:football_news/core/extensions/color.dart';
import 'package:football_news/core/extensions/nums.dart';
import 'package:football_news/ui/themes/app_colors.dart';
import 'package:football_news/ui/widgets/grouped_fixtures_list.dart';
import 'package:football_news/ui/widgets/league_rectangle.dart';
import 'package:get/get.dart';

class Fixtures extends StatelessWidget {
  const Fixtures({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FixtureController>();

    return Column(
      children: [
        Obx(() {
          final visibleLeagues = controller.visibleLeagues;

          return visibleLeagues.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: const Center(child: CircularProgressIndicator()),
                )
              : LeagueRectangle(
                  leagues: visibleLeagues,
                  getFixtures: true,
                  prefixIcon: _getPrefixIcon(),
                );
        }),

        Obx(() {
          final fixtures = controller.items;
          return fixtures.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: const Center(child: CircularProgressIndicator()),
                )
              : Expanded(
                  child: GroupedFixturesList(
                    fixtures: fixtures,
                    showLeagueLogo: true,
                  ),
                );
        }),
      ],
    );
  }

  Widget _getPrefixIcon() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.radius),
        gradient: AppColors.blueGradient,
        border: Border.all(color: AppColors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacitySafe(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: const Icon(Icons.public, color: AppColors.white),
    );
  }
}
