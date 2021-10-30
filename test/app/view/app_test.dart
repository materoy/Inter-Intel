// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_test/flutter_test.dart';
import 'package:inter_intel_interview/app/app.dart';
import 'package:inter_intel_interview/info/view/info_screen.dart';
import 'package:inter_intel_interview/widgets/base_scaffold.dart';
import 'package:inter_intel_interview/widgets/bottom_nav_bar/bottom_nav_bar.dart';

void main() {
  group('App', () {
    testWidgets('renders Base scaffold', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(BaseScaffold), findsOneWidget);
    });

    testWidgets('renders Info screen', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(InfoScreen), findsOneWidget);
    });

    testWidgets('renders bottom navigation bar', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(BottomNavBar), findsOneWidget);
    });
  });
}
