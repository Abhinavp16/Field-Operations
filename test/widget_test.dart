import 'package:field_operations/app/field_ops_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Field Operations app renders splash screen', (tester) async {
    await tester.pumpWidget(FieldOpsApp());

    expect(find.text('Field Operations'), findsOneWidget);
    expect(
      find.text('Secure field activity and audit platform'),
      findsOneWidget,
    );

    await tester.pump(const Duration(milliseconds: 900));
  });
}
