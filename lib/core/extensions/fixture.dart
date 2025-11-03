import 'package:flutter/material.dart';
import 'package:football_news/core/models/domain/soccer_fixture.dart';
import 'package:football_news/ui/themes/app_colors.dart';

extension FixtureExtension on SoccerFixture {
  Gradient get gradientColor {
    return isThereWinner ? AppColors.redGradient : AppColors.blueGradient;
  }

  bool get isThereWinner {
    return teams.away.score != teams.home.score;
  }
}
