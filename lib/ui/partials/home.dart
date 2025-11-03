import 'package:flutter/material.dart';
import 'package:football_news/ui/components/layout.dart';
import 'package:football_news/ui/widgets/live_score.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(content: LiveScore());
  }
}
