import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsfunnel_frontend/core/utils/modal.util.dart';

class NavbarCreatePostButtonWidget extends StatefulWidget {
  const NavbarCreatePostButtonWidget({super.key});

  @override
  State<NavbarCreatePostButtonWidget> createState() => _NavbarCreatePostButtonWidgetState();
}

class _NavbarCreatePostButtonWidgetState extends State<NavbarCreatePostButtonWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final themeData = CupertinoTheme.of(context);
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () => ModalUtil().openBottomDrawer(
        context: context,
        //   child: CreatePostModalWidget(),
        child: const Placeholder(),
      ),
      child: Container(
        width: 48,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TweenAnimationBuilder<Color?>(
          duration: const Duration(milliseconds: 150),
          tween: ColorTween(
            begin: themeData.primaryColor,
            end: _isPressed ? themeData.primaryColor : CupertinoColors.systemBackground,
          ),
          curve: Curves.easeInOut,
          builder: (context, color, _) {
            return Icon(
              FluentIcons.add_16_filled,
              color: color,
            );
          },
        ),
      ),
    );
  }
}
