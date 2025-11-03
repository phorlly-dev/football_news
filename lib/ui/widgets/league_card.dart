import 'package:flutter/material.dart';
import 'package:football_news/core/extensions/color.dart';
import 'package:football_news/core/extensions/nums.dart';
import 'package:football_news/core/models/domain/league.dart';
import 'package:football_news/ui/components/custom_image.dart';
import 'package:football_news/ui/themes/app_colors.dart';
import 'package:hexcolor/hexcolor.dart';

class LeagueCard extends StatelessWidget {
  final League league;
  final bool isSelected;
  final bool viewCountryName;

  const LeagueCard({
    super.key,
    required this.league,
    this.isSelected = false,
    this.viewCountryName = false,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: isSelected ? 1.05 : 1.0, // Slightly scale up when selected
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.radius),
          gradient: isSelected ? AppColors.redGradient : null,
          color: isSelected
              ? null
              : league.color != null
              ? HexColor(league.color!)
              : AppColors.blueGrey,
          border: isSelected
              ? Border.all(
                  color: AppColors.white,
                  width: 2,
                ) // Add white border when selected
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.black.withOpacitySafe(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null, // Add shadow when selected
        ),
        child: Row(
          children: [
            CustomImage(
              width: 42.radius,
              height: 42.radius,
              imageUrl: league.logo,
              fit: BoxFit.contain,
              borderRadius: BorderRadius.circular(12),
            ),
            SizedBox(width: 5.width),
            Text(
              league.name +
                  (viewCountryName && league.country != null
                      ? ' (${league.country?.name})'
                      : ''),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.white,
                fontWeight: isSelected
                    ? FontWeight.bold
                    : FontWeight.normal, // Bold text when selected
              ),
            ),
            if (isSelected) // Add a checkmark icon when selected
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
