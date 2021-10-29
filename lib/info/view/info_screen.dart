import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:inter_intel_interview/app/utils/size_config.dart';
import 'package:inter_intel_interview/design/design.dart';
import 'package:inter_intel_interview/info/cubit/info_cubit.dart';
import 'package:inter_intel_interview/info/info.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

part 'input_widgets.dart';
part 'submit_button.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InfoCubit(),
      child: SingleChildScrollView(
        child: SizedBox(
          height: SizeConfig.height,
          width: SizeConfig.width,
          child: const InfoForm(),
        ),
      ),
    );
  }
}

class InfoForm extends StatelessWidget {
  const InfoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<InfoCubit, InfoState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          final user = User(
              firstName: state.firstName,
              lastName: state.lastName,
              email: state.email.value,
              phoneNumber: state.phoneNumber.value);

          /// Navigates to the design screen
          DesignScreen.route(context, user);
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('Submisson failed')));
        } else if (state.status.isInvalid) {
          Get.snackbar<void>('Invalid', 'Please fill in all the form details');
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: SizeConfig.unitHeight * 5),
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.unitWidth * 4),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20)),
            color: Theme.of(context).scaffoldBackgroundColor),
        child: Column(children: [
          Row(
            children: [
              Expanded(child: _FirstNameInput()),
              SizedBox(width: SizeConfig.unitWidth * 2),
              Expanded(child: _LastNameInput()),
            ],
          ),
          _EmailInput(),
          _PhoneNumberInput(),
          _SubmitButton(),
        ]),
      ),
    );
  }
}
