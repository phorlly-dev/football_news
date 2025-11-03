import 'package:flutter/material.dart';
import 'package:football_news/core/extensions/nums.dart';
import 'package:football_news/core/extensions/strings.dart';
import 'package:football_news/core/models/domain/teams.dart';
import 'package:football_news/ui/components/custom_image.dart';
import 'package:football_news/ui/themes/app_colors.dart';

class ViewTeam extends StatelessWidget {
  final Team team;

  const ViewTeam({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImage(width: 50.radius, height: 50.radius, imageUrl: team.logo),
        SizedBox(height: 10.height),
        FittedBox(
          child: Text(
            team.name.teamName,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
