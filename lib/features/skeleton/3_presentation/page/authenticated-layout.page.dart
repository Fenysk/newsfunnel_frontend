import 'package:flutter/cupertino.dart';
import 'package:newsfunnel_frontend/features/mails/3_presentation/page/home.page.dart';
import 'package:newsfunnel_frontend/features/user/3_presentation/page/profile.page.dart';
import 'package:newsfunnel_frontend/core/constants/app-icons.constants.dart';

class AuthenticatedLayoutPage extends StatelessWidget {
  const AuthenticatedLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: const SafeArea(
        child: NavigatorWidget(),
      ),
    );
  }
}

class NavigatorWidget extends StatelessWidget {
  const NavigatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(AppIcons.mail),
            label: 'Mails',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.person),
            label: 'Profile',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            return SafeArea(
              child: Navigator(
                initialRoute: '/',
                onGenerateRoute: (RouteSettings settings) {
                  Widget page;
                  switch (index) {
                    case 1:
                      page = const ProfilePage();
                      break;
                    default:
                      page = const HomePage();
                  }
                  return CupertinoPageRoute(
                    settings: settings,
                    builder: (_) => page,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget buildLoadingContent() {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }
}
