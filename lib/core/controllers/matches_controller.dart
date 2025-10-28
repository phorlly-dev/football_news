import 'package:football_news/core/controllers/controller.dart';
import 'package:football_news/core/models/matches.dart';

class MatchesController extends Controller<Matches> {
  MatchesController() : super(path: 'matches', fromJson: Matches.fromJson);

  // @override
  // void onInit() {
  //   binds();
  //   super.onInit();
  // }
}
