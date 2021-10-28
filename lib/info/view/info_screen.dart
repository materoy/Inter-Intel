import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:inter_intel_interview/app/utils/size_config.dart';
import 'package:inter_intel_interview/info/cubit/info_cubit.dart';

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
          Navigator.pop(context);
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('Sign up failed')));
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.unitWidth * 4),
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

class _FormTextField extends StatelessWidget {
  const _FormTextField({
    Key? key,
    this.textFieldKey,
    required this.onChanged,
    required this.keyboardType,
    required this.labelText,
    this.errorText,
    this.obscureText,
  }) : super(key: key);

  final Key? textFieldKey;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  final String labelText;
  final String? errorText;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.unitHeight * 2),
      height: SizeConfig.unitHeight * 10,
      child: TextFormField(
        key: key,
        onChanged: onChanged,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: labelText,
          errorText: errorText,
        ),
      ),
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoCubit, InfoState>(
      builder: (context, state) {
        return _FormTextField(
          key: const Key('infoForm_firstNameInput_textField'),
          onChanged: (firstName) =>
              context.read<InfoCubit>().firstNameChanged(firstName),
          keyboardType: TextInputType.name,
          labelText: 'First name',
        );
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoCubit, InfoState>(
      builder: (context, state) {
        return _FormTextField(
          key: const Key('infoForm_lastNameInput_textField'),
          onChanged: (lastName) =>
              context.read<InfoCubit>().lastNameChanged(lastName),
          keyboardType: TextInputType.emailAddress,
          labelText: 'Last name',
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoCubit, InfoState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return _FormTextField(
          key: const Key('infoForm_emailInput_textField'),
          onChanged: (email) => context.read<InfoCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          labelText: 'email',
          errorText: state.email.invalid ? 'invalid email' : null,
        );
      },
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoCubit, InfoState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return _FormTextField(
          key: const Key('infoForm_phoneNumberInput_textField'),
          onChanged: (email) => context.read<InfoCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          labelText: 'Phone number',
          errorText: state.email.invalid ? 'invalid email' : null,
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoCubit, InfoState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('infoForm_submit_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: Colors.orangeAccent,
                ),
                onPressed: state.status.isValidated
                    ? () => context.read<InfoCubit>().submitForm()
                    : null,
                child: const Text('SUBMIT'),
              );
      },
    );
  }
}
