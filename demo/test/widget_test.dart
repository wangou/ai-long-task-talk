import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:figma_home_demo/main.dart';

void main() {
  testWidgets('renders the fixed Figma phone canvas shell', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final phoneCanvas = find.byKey(const ValueKey('phone-canvas'));
    expect(phoneCanvas, findsOneWidget);
    expect(tester.getSize(phoneCanvas), const Size(390, 844));

    expect(find.byKey(const ValueKey('status-bar')), findsOneWidget);
    expect(find.byKey(const ValueKey('first-post-card')), findsOneWidget);
    expect(find.byKey(const ValueKey('second-post-card')), findsOneWidget);
    expect(find.byKey(const ValueKey('bottom-navigation')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('floating-action-button')),
      findsOneWidget,
    );

    expect(
      find.text(
        'Flutter preview is live, with local assets and a clean golden test.',
      ),
      findsOneWidget,
    );
    expect(find.text('HOME'), findsOneWidget);
    expect(find.text('CHAT'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsNothing);
    expect(find.byKey(const ValueKey('photo-strip-scroll')), findsNWidgets(2));
  });

  testWidgets('captures the phone canvas golden', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: PhoneCanvas()),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(PhoneCanvas),
      matchesGoldenFile('goldens/phone_canvas.png'),
    );
  });
}
