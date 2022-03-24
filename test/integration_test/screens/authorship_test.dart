import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lab1_bmi/constants.dart';
import 'package:flutter/material.dart';
import 'package:lab1_bmi/screens/authorship.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('authorship.dart', () {
    testWidgets('all text is rendered correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Authorship(),
      ));

      await tester.pumpAndSettle();

      // Verify the app title is available
      var appTitle = find.text(Constants.authorship['appTitle']);
      expect(appTitle, findsOneWidget);

      // Verify the author is available
      var author = find.text(Constants.authorship['author']);
      expect(author, findsOneWidget);

      // Verify the title is available
      var title = find.text(Constants.authorship['title']);
      expect(title, findsOneWidget);
    });
  });
}
