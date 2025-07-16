import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper_game/app/app.dart';
import 'package:minesweeper_game/core/constant/app_string_constant.dart';

void main() {
  testWidgets('App initializes correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyApp());

    // Verify that the initial menu screen is shown
    expect(find.text(appName), findsOneWidget);
    expect(find.text(selectDifficultyText), findsOneWidget);
    expect(find.text(easyText), findsOneWidget);
    expect(find.text(mediumText), findsOneWidget);
    expect(find.text(hardText), findsOneWidget);
  });
}
