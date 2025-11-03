import 'package:flutter/material.dart';
import 'package:football_news/core/extensions/nums.dart';
import 'package:football_news/core/models/domain/league.dart';
import 'package:football_news/ui/widgets/league_card.dart';

class LeagueRectangle extends StatefulWidget {
  final List<League> leagues;
  final bool getFixtures;
  final int? initialSelectedLeagueId;
  final Widget? prefixIcon;
  final VoidCallback? onPrefixIconTap;
  const LeagueRectangle({
    super.key,
    required this.leagues,
    required this.getFixtures,
    this.initialSelectedLeagueId,
    this.prefixIcon,
    this.onPrefixIconTap,
  });

  @override
  State<LeagueRectangle> createState() => _LeagueRectangleState();
}

class _LeagueRectangleState extends State<LeagueRectangle> {
  int? selectedLeagueId;

  @override
  initState() {
    super.initState();
    selectedLeagueId = widget.initialSelectedLeagueId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      height: 46.height,
      child: Row(
        children: [
          if (widget.prefixIcon != null) ...[
            GestureDetector(
              onTap: () {
                if (widget.onPrefixIconTap != null) {
                  widget.onPrefixIconTap!();
                }
                setState(() => selectedLeagueId = null);
              },
              child: widget.prefixIcon,
            ),
            SizedBox(width: 5.width),
          ],
          Expanded(
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.leagues.length,
              separatorBuilder: (ctx, idx) => SizedBox(width: 5.width),
              itemBuilder: (context, index) {
                final viewCountryName = widget.leagues.any((l) {
                  return l.name == widget.leagues[index].name &&
                      l.id != widget.leagues[index].id;
                });
                return InkWell(
                  onTap: () {
                    setState(() => selectedLeagueId = widget.leagues[index].id);
                  },
                  child: LeagueCard(
                    league: widget.leagues[index],
                    isSelected: selectedLeagueId == widget.leagues[index].id,
                    viewCountryName: viewCountryName,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
