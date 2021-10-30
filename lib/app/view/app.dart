// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inter_intel_interview/app/theme/theme.dart';
import 'package:inter_intel_interview/app/utils/size_config.dart';
import 'package:inter_intel_interview/l10n/l10n.dart';
import 'package:inter_intel_interview/widgets/base_scaffold.dart';
import 'package:inter_intel_interview/widgets/bottom_nav_bar/cubit/bottom_nav_bar_cubit.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavBarCubit>(
          create: (context) => BottomNavBarCubit(),
        )
      ],
      child: MaterialApp(
        theme: lightTheme,
        // darkTheme: darkTheme,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const BaseScaffold(),
        builder: (context, child) {
          SizeConfig().initialize(context);
          return child!;
        },
      ),
    );
  }
}
