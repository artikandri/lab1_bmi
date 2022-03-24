import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:lab1_bmi/utils/integration_test.dart';
import 'package:lab1_bmi/screens/authorship.dart';
import 'package:lab1_bmi/constants.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('authorship.dart', () {
    testWidgets('all text is rendered correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Authorship(),
      ));
      await tester.pumpAndSettle();

      // Verify the app title is rendered
      var appTitle = find.text(Constants.authorship['appTitle']);
      expect(appTitle, findsOneWidget);

      // verify author text is rendered
      find.byWidgetPredicate((widget) => fromRichTextToPlainText(widget) == Constants.authorship['appTitle']);
    });
  });
}
