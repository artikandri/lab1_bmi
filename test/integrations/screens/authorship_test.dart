import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

import 'package:lab1_bmi/screens/authorship.dart' as authorship;
import 'package:lab1_bmi/styling.dart';
import 'package:lab1_bmi/constants.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('authorship.dart', () {
    testWidgets('all text is rendered correctly', (WidgetTester tester) async {
      await tester.pumpAndSettle();

      // Verify the app title is available
      var appTitle = find.text(Constants.authorship['appTitle']);
      expect(appTitle, Constants.authorship['appTitle']);

      // Verify the author is available
      var author = find.text(Constants.authorship['author']);
      expect(author, Constants.authorship['author']);

      // Verify the title is available
      var title = find.text(Constants.authorship['title']);
      expect(title, Constants.authorship['title']);
    });
  });
}
