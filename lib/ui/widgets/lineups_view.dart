import 'package:flutter/material.dart';
import 'package:football_news/core/extensions/nums.dart';
import 'package:football_news/core/extensions/strings.dart';
import 'package:football_news/core/models/domain/fixture_details.dart';
import 'package:football_news/core/models/domain/teams.dart';
import 'package:football_news/core/utils/app_assets.dart';
import 'package:football_news/core/utils/app_strings.dart';
import 'package:football_news/ui/components/custom_image.dart';
import 'package:football_news/ui/components/items_not_available.dart';
import 'package:football_news/ui/widgets/teams_lineups.dart';
import 'package:football_news/ui/themes/app_colors.dart';
import 'package:football_news/ui/themes/app_fonts.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

class LineupsView extends StatelessWidget {
  final FixtureDetails? fixtureDetails;
  final Color? color;

  const LineupsView({super.key, required this.fixtureDetails, this.color});

  @override
  Widget build(BuildContext context) {
    final homeTeam = fixtureDetails?.fixture.teams.home;
    final awayTeam = fixtureDetails?.fixture.teams.away;
    return (homeTeam?.lineup?.formation ?? '').isNotEmpty &&
            (awayTeam?.lineup?.formation ?? '').isNotEmpty
        ? Column(
            children: [
              buildTeamHeader(context: context, team: homeTeam!),
              Container(
                width: double.infinity,
                height: context.height * .8,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(AppAssets.playground),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ).copyWith(top: 20),
                  child: TeamsLineups(fixtureDetails: fixtureDetails!),
                ),
              ),
              buildTeamHeader(context: context, team: awayTeam!),
            ],
          )
        : ItemsNotAvailable(
            icon: Icons.people,
            message: AppStrings.noLineups,
            color: color,
          );
  }

  Widget buildTeamHeader({required BuildContext context, required Team team}) {
    return Container(
      color: AppColors.darkGreen,
      padding: const EdgeInsetsDirectional.all(5),
      child: Row(
        children: [
          CustomImage(width: 35.radius, height: 35.radius, imageUrl: team.logo),
          SizedBox(width: 10.width),
          Text(
            team.name.teamName,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Spacer(),
          Text(
            team.lineup!.formation,
            style: const TextStyle(
              color: Colors.white,
              fontSize: FontSize.subTitle,
            ),
          ),
          SizedBox(width: 10.width),
        ],
      ),
    );
  }
}
