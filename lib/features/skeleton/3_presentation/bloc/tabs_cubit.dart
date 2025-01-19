import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsfunnel_frontend/features/skeleton/3_presentation/widgets/navbar-button.widget.dart';

part 'tabs_state.dart';

class TabsCubit extends Cubit<TabsState> {
  TabsCubit() : super(HomeTab());

  void selectTab(
    BuildContext context,
    NavbarButtonType type, {
    String? userId,
  }) {
    Navigator.of(context, rootNavigator: true).pushNamed(type.name);
    emit(
      switch (type) {
        NavbarButtonType.home => HomeTab(),
        NavbarButtonType.search => SearchTab(),
        NavbarButtonType.activity => ActivityTab(),
        NavbarButtonType.profile => ProfileTab(userId: userId),
      },
    );
  }
}
