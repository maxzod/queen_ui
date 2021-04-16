import 'dart:developer';

import 'package:flutter/material.dart';

/// * UI compoent acting as navigation Bar
/// * if scrren width is less than 1010 pixle it will show logo + first child + button
/// * else it will show all the the children

class QueenNavBar extends StatelessWidget {
  final List<Widget> children;

  /// * [required]
  final Widget logo;

  /// *  [Optional] default is blue
  final Color color;

  /// * [optional] deffult is left-to-right
  final TextDirection textDirection;

  final WidgetBuilder? drawerButtonBuilder;

  const QueenNavBar({
    this.logo = const SizedBox(),
    this.drawerButtonBuilder,
    this.children = const [],
    this.color = Colors.deepOrange,
    this.textDirection = TextDirection.ltr,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bar = screenWidth < 1010
        ? buildForSmallScreens(context)
        : buildForLargeScreens();
    return Container(
      height: AppBar().preferredSize.height,
      width: double.infinity,
      color: color,
      child: Directionality(
        textDirection: textDirection,
        child: bar,
      ),
    );
  }

  Widget buildDrawerButton(BuildContext context) {
    if (children.length > 1) {
      // you need a drawer button
      // if no builder provider the bulild standerd one
      if (drawerButtonBuilder == null) {
        return OutlinedButton(
          onPressed: () {
            const String msg =
                'build your DrawerButton using `drawerButtonBuilder` in QueenNavBar constractcor';
            log(msg);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(msg), backgroundColor: Colors.amber),
            );
          },
          child: const Icon(Icons.menu),
        );
      } else {
        return drawerButtonBuilder == null
            ? const SizedBox()
            : drawerButtonBuilder!(context);
      }
    } else {
      return const SizedBox();
    }
  }

  Widget buildForSmallScreens(BuildContext context) {
    final Widget firstChild =
        children.isNotEmpty ? children[0] : const SizedBox();

    return Center(
      child: Row(
        children: [
          logo,
          const Spacer(),
          firstChild,
          buildDrawerButton(context),
        ],
      ),
    );
  }

  Widget buildForLargeScreens() {
    return Center(
      child: Row(
        children: [
          logo,
          const Spacer(),
          ...children,
        ],
      ),
    );
  }
}
