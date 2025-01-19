import 'package:flutter/cupertino.dart';
import 'package:newsfunnel_frontend/features/auth/3_presentation/widget/login.tab.dart';
import 'package:newsfunnel_frontend/features/auth/3_presentation/widget/register.tab.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  int _selectedIndex = 0;

  void switchToLoginTab() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  void switchToRegisterTab() {
    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        top: false,
        bottom: true,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 9),
                const Text(
                  'Newsfunnel',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: IndexedStack(
                          index: _selectedIndex,
                          children: [
                            RegisterTab(onGoToLoginTab: switchToLoginTab),
                            LoginTab(onGoToRegisterTab: switchToRegisterTab),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
