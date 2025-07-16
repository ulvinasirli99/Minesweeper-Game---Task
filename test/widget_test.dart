import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper_game/app/app.dart';

void main() {
  testWidgets('Game initializes correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyApp());

    // Verify that the initial game screen is shown
    expect(find.text('Minesweeper'), findsOneWidget);
    expect(find.text('Select Difficulty'), findsOneWidget);
    expect(find.text('Easy'), findsOneWidget);
    expect(find.text('Medium'), findsOneWidget);
    expect(find.text('Hard'), findsOneWidget);
  });
}
