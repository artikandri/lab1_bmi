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

      final richTextWidget = tester.element(richTextFinder).widget as RichText;
      print(richTextWidget.text.children);
    });
  });
}
