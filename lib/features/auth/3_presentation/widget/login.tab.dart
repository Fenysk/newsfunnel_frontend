import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsfunnel_frontend/core/widgets/loading-button/bloc/loading-button.state-cubit.dart';
import 'package:newsfunnel_frontend/core/widgets/loading-button/bloc/loading-button.state.dart';
import 'package:newsfunnel_frontend/core/widgets/loading-button/custom-loading-button.widget.dart';
import 'package:newsfunnel_frontend/features/auth/1_data/dto/login.request.dart';
import 'package:newsfunnel_frontend/features/auth/2_domain/usecase/login.usecase.dart';
import 'package:newsfunnel_frontend/features/skeleton/3_presentation/page/authenticated.page.dart';
import 'package:newsfunnel_frontend/service_locator.dart';

class LoginTab extends StatelessWidget {
  final void Function() onGoToRegisterTab;

  LoginTab({
    super.key,
    required this.onGoToRegisterTab,
  });

  final _emailController = TextEditingController(text: 'test@test.test');
  final _passwordController = TextEditingController(text: 'Password1@');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoadingButtonCubit(),
      child: BlocListener<LoadingButtonCubit, LoadingButtonState>(
        listener: (context, state) {
          if (state is LoadingButtonSuccessState) {
            Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (_) => const AuthenticatedPage()));
          }

          if (state is LoadingButtonFailureState) {
            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text('Error'),
                content: Text('Error logging in: ${state.errorMessage}'),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                CupertinoTextField(
                  controller: _emailController,
                  placeholder: 'Email',
                  prefix: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(CupertinoIcons.mail),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                ),
                const SizedBox(height: 16),
                CupertinoTextField(
                  obscureText: true,
                  controller: _passwordController,
                  placeholder: 'Password',
                  prefix: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(CupertinoIcons.lock),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                ),
                const SizedBox(height: 24),
                Builder(
                  builder: (buttonContext) {
                    return CustomLoadingButton(
                      text: 'Login',
                      onPressed: () {
                        buttonContext.read<LoadingButtonCubit>().execute(
                              usecase: serviceLocator<LoginUsecase>(),
                              params: LoginRequest(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
                CupertinoButton(
                  onPressed: onGoToRegisterTab,
                  child: const Text('Go back to register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
