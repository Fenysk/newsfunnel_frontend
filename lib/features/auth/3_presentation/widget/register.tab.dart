import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/features/user/2_domain/repository/users.repository.dart';
import 'package:newsfunnel_frontend/core/widgets/loading-button/bloc/loading-button.state-cubit.dart';
import 'package:newsfunnel_frontend/core/widgets/loading-button/bloc/loading-button.state.dart';
import 'package:newsfunnel_frontend/core/widgets/loading-button/custom-loading-button.widget.dart';
import 'package:newsfunnel_frontend/features/auth/1_data/dto/register.request.dart';
import 'package:newsfunnel_frontend/features/auth/2_domain/usecase/register.usecase.dart';
import 'package:newsfunnel_frontend/service_locator.dart';
import 'dart:async';

class RegisterTab extends StatelessWidget {
  final VoidCallback onGoToLoginTab;

  RegisterTab({
    super.key,
    required this.onGoToLoginTab,
  });

  final _formKey = GlobalKey<FormState>();
  final _pseudoController = TextEditingController(text: 'Test');
  final _emailController = TextEditingController(text: 'test@test.test');
  final _passwordController = TextEditingController(text: 'Password1@');

  Timer? _checkIfPseudoExistDebounce;
  String? checkIfPseudoExistErrorMessage;

  String? _validatePseudo(String? pseudo) {
    if (pseudo == null || pseudo.isEmpty) {
      return 'Pseudo is required';
    }

    return checkIfPseudoExistErrorMessage;
  }

  String? _validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Invalid email format';
    }

    return null;
  }

  String? _validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if (!passwordRegex.hasMatch(password)) {
      return 'Password must contain at least 8 characters, 1 uppercase letter, 1 lowercase letter, 1 number and 1 special character';
    }

    return null;
  }

  Future<void> _checkIfPseudoExist(String pseudo) async {
    _checkIfPseudoExistDebounce?.cancel();

    _checkIfPseudoExistDebounce = Timer(const Duration(milliseconds: 300), () async {
      final result = await serviceLocator<UsersRepository>().checkIfPseudoExist(pseudo);
      checkIfPseudoExistErrorMessage = result.fold((error) => error, (_) => null);
      _formKey.currentState?.validate();
    });
  }

  void _onRegisterPressed(BuildContext buttonContext) async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      buttonContext.read<LoadingButtonCubit>().execute(
            usecase: serviceLocator<RegisterUsecase>(),
            params: RegisterRequest(
              pseudo: _pseudoController.text,
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    _formKey.currentState?.validate();

    return BlocProvider(
      create: (context) => LoadingButtonCubit(),
      child: BlocListener<LoadingButtonCubit, LoadingButtonState>(
        listener: (context, state) {
          if (state is LoadingButtonSuccessState) {
            Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
              return const Placeholder();
            }));
          }

          if (state is LoadingButtonFailureState) {
            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text('Error'),
                content: Text('Error creating account: ${state.errorMessage}'),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('OK'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextField(
                    controller: _pseudoController,
                    onChanged: _checkIfPseudoExist,
                    placeholder: 'Pseudo',
                    prefix: const Icon(
                      CupertinoIcons.person,
                      color: CupertinoColors.systemGrey,
                    ),
                    padding: const EdgeInsets.all(12),
                  ),
                  if (_validatePseudo(_pseudoController.text) != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        _validatePseudo(_pseudoController.text)!,
                        style: const TextStyle(color: CupertinoColors.systemRed),
                      ),
                    ),
                  const SizedBox(height: 20),
                  CupertinoTextField(
                    controller: _emailController,
                    placeholder: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    prefix: const Icon(
                      CupertinoIcons.mail,
                      color: CupertinoColors.systemGrey,
                    ),
                    padding: const EdgeInsets.all(12),
                  ),
                  if (_validateEmail(_emailController.text) != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        _validateEmail(_emailController.text)!,
                        style: const TextStyle(color: CupertinoColors.systemRed),
                      ),
                    ),
                  const SizedBox(height: 16),
                  CupertinoTextField(
                    controller: _passwordController,
                    placeholder: 'Password',
                    obscureText: true,
                    prefix: const Icon(
                      CupertinoIcons.lock,
                      color: CupertinoColors.systemGrey,
                    ),
                    padding: const EdgeInsets.all(12),
                  ),
                  if (_validatePassword(_passwordController.text) != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        _validatePassword(_passwordController.text)!,
                        style: const TextStyle(color: CupertinoColors.systemRed),
                      ),
                    ),
                  const SizedBox(height: 24),
                  Builder(
                    builder: (buttonContext) {
                      return CustomLoadingButton(
                        text: 'Register',
                        onPressed: () => _onRegisterPressed(buttonContext),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  CupertinoButton(
                    onPressed: onGoToLoginTab,
                    child: const Text('Go to login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
