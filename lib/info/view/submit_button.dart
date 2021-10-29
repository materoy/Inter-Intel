part of 'info_screen.dart';

class _SubmitButton extends StatefulWidget {
  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();

  Future<void> _submitButtonClick() async {
    final infoCubit = context.read<InfoCubit>();
    if (infoCubit.state.status.isValidated) {
      infoCubit.emit(
          infoCubit.state.copyWith(status: FormzStatus.submissionInProgress));
      await Future<void>.delayed(const Duration(seconds: 3));
      _buttonController.success();
      await infoCubit.submitForm();
    } else {
      infoCubit.emit(infoCubit.state.copyWith(status: FormzStatus.invalid));
      _buttonController.error();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoCubit, InfoState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return RoundedLoadingButton(
            key: const Key('infoForm_submit_raisedButton'),
            controller: _buttonController,
            onPressed: _submitButtonClick,
            resetAfterDuration: true,
            resetDuration: const Duration(seconds: 3),
            child: Text(
              'SUBMIT',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                  ),
            ));
      },
    );
  }
}
