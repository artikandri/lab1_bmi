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

      // verify title  is rendered
      expect(find.byWidgetPredicate((Widget widget) => widget is RichText && widget.text.toPlainText() == Constants.authorship['appTitle']), findsOneWidget);

      // verify author is rendered
      expect(find.byWidgetPredicate((Widget widget) => widget is RichText && widget.text.toPlainText() == Constants.authorship['author']), findsOneWidget);
    });
  });
}
