import 'package:flutter_test/flutter_test.dart';
import 'package:mob_ui/main.dart';

void main() {
  testWidgets('Vanika smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const VanikaMobileApp());
    expect(find.text('VANIKA'), findsOneWidget);
  });
}
