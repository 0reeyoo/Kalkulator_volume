import 'package:flutter_test/flutter_test.dart';
import 'package:flutterlat1/main.dart'; 

void main() {
  testWidgets('Cek tampilan aplikasi', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Kalkulator Volume'), findsOneWidget);
  });
}