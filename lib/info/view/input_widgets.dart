part of 'info_screen.dart';

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
      height: SizeConfig.unitHeight * 15,
      child: TextFormField(
        key: key,
        onChanged: onChanged,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none),
            fillColor: Theme.of(context).primaryColor.withOpacity(.15),
            filled: true,
            contentPadding: const EdgeInsets.only(left: 20),
            labelText: labelText,
            errorText: errorText,
            labelStyle: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Theme.of(context).primaryColor)),
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
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: _FormTextField(
                key: const Key('infoForm_codeInput_textField'),
                onChanged: (phoneNumber) =>
                    context.read<InfoCubit>().phoneNumberChanged(phoneNumber),
                keyboardType: TextInputType.phone,
                labelText: 'code',
              ),
            ),
            SizedBox(width: SizeConfig.unitWidth * 3),
            Expanded(
              flex: 3,
              child: _FormTextField(
                key: const Key('infoForm_phoneNumberInput_textField'),
                onChanged: (phoneNumber) =>
                    context.read<InfoCubit>().phoneNumberChanged(phoneNumber),
                keyboardType: TextInputType.phone,
                labelText: 'Phone number',
                errorText:
                    state.phoneNumber.invalid ? 'invalid phone number' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
