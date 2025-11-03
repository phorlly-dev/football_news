import 'package:flutter/material.dart';
import 'package:football_news/core/backups/league_controller.dart';
import 'package:football_news/core/extensions/nums.dart';
import 'package:football_news/ui/components/custom_image.dart';
import 'package:get/get.dart';

class LeaguesList extends StatelessWidget {
  const LeaguesList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LeagueControllerX>();
    return Obx(() {
      final leagues = controller.items;

      if (leagues.isEmpty) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      return SizedBox(
        height: 100,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: leagues.length,
          separatorBuilder: (ctx, idex) => const SizedBox(width: 12),
          itemBuilder: (context, i) {
            final league = leagues[i];
            return GestureDetector(
              onTap: () {
                print('Selected ${league.name} ${league.id}');
              },
              child: CircleAvatar(
                backgroundColor: Colors.cyanAccent,
                radius: 26.radius,
                child: CustomImage(
                  fit: BoxFit.contain,
                  width: 36.radius,
                  height: 36.radius,
                  imageUrl: league.logo ?? '',
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
