import 'package:flutter/cupertino.dart';
import 'package:newsfunnel_frontend/features/user/3_presentation/page/profile.page.dart';

class AuthenticatedPage extends StatelessWidget {
  const AuthenticatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      //   navigationBar: CupertinoNavigationBar(
      //     middle: BlocProvider(
      //       create: (context) => TabsCubit(),
      //       child: BlocBuilder<TabsCubit, TabsState>(
      //         builder: (context, state) {
      //           return AppBottomNavigationBar(
      //             tabState: state,
      //           );
      //         },
      //       ),
      //     ),
      //   ),
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
    return CupertinoTabView(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context) {
        return Navigator(
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            Widget page;
            switch (settings.name) {
              case '/profile':
                page = const ProfilePage();
                break;
              default:
                page = const ProfilePage();
            }
            return CupertinoPageRoute(
              settings: settings,
              builder: (_) => page,
            );
          },
        );
      },
      //   child: BlocProvider(
      //     create: (context) => TabsCubit(),
      //     child: BlocBuilder<TabsCubit, TabsState>(
      //       builder: (context, state) {
      //         return Column(
      //           children: [
      //             Expanded(
      //               child: switch (state) {
      //                 HomeTab() => const HomePage(),
      //                 SearchTab() => const SearchPage(),
      //                 ProfileTab() => ProfilePage(userId: state.userId),
      //                 _ => buildLoadingContent(),
      //               },
      //             ),
      //             AppBottomNavigationBar(
      //               tabState: state,
      //             ),
      //           ],
      //         );
      //       },
      //     ),
      //   ),
    );
  }

  Widget buildLoadingContent() {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }
}
