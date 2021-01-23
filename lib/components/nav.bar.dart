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

  final Widget Function(BuildContext context) drawerButtonBuilder;

  QueenNavBar({
    @required this.logo,
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
      color: this.color,
      child: Directionality(
        textDirection: this.textDirection,
        child: bar,
      ),
    );
  }

  Widget buildDrawerButton(context) {
    if (this.children.length > 1) {
      // you need a drawer button
      // if no builder provider the bulild standerd one
      if (this.drawerButtonBuilder == null) {
        return OutlineButton(
          onPressed: () {
            const String msg =
                'build your DrawerButton using `drawerButtonBuilder` in QueenNavBar constractcor';
            print(msg);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(msg),
              backgroundColor: Colors.amber,
            ));
          },
          child: const Icon(Icons.menu),
        );
      } else {
        return this.drawerButtonBuilder(context);
      }
    } else {
      return Container();
    }
  }

  Widget buildForSmallScreens(context) {
    final Widget firstChild =
        this.children.length > 0 ? this.children[0] : Container();

    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          this.logo ?? const Text("Queen 👑"),
          const Spacer(),
          firstChild,
          buildDrawerButton(context)
        ],
      ),
    );
  }

  Widget buildForLargeScreens() {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          this.logo ?? const Text("Queen 👑"),
          const Spacer(),
          ...this.children,
        ],
      ),
    );
  }
}
