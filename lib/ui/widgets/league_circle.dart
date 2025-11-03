import 'package:flutter/material.dart';
import 'package:football_news/core/extensions/nums.dart';
import 'package:football_news/core/models/domain/league.dart';
import 'package:football_news/ui/components/custom_image.dart';
import 'package:football_news/ui/themes/app_colors.dart';
import 'package:hexcolor/hexcolor.dart';

class LeagueCircle extends StatelessWidget {
  final List<League> leagues;
  const LeagueCircle({super.key, required this.leagues});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65.height,
      padding: const EdgeInsetsDirectional.only(start: 15),
      decoration: BoxDecoration(
        gradient: AppColors.blueGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50.radius),
          topLeft: Radius.circular(50.radius),
        ),
      ),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, indx) {
          final league = leagues[indx];
          if (indx == leagues.length - 1) {
            return Row(
              children: [
                _leagueAvatar(league, context),
                SizedBox(width: 10.width),
              ],
            );
          }
          return _leagueAvatar(league, context);
        },
        separatorBuilder: (_, _) => SizedBox(width: 10.width),
        itemCount: leagues.length,
      ),
    );
  }

  Widget _leagueAvatar(League league, BuildContext context) {
    return InkWell(
      onTap: () {},
      child: CircleAvatar(
        backgroundColor: league.color != null
            ? HexColor(league.color!)
            : AppColors.blueGrey,
        radius: 25.radius,
        child: CustomImage(
          fit: BoxFit.contain,
          width: 25.radius,
          height: 25.radius,
          imageUrl: league.logo,
        ),
      ),
    );
  }
}
