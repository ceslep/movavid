import 'package:flutter/material.dart';

class AppPage extends StatelessWidget {
  final String title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget body;
  final bool showBack;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final double maxWidth;

  const AppPage({
    super.key,
    required this.title,
    this.titleWidget,
    this.actions,
    required this.body,
    this.showBack = true,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.maxWidth = 1100,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: titleWidget ?? Text(title),
        leading: showBack
            ? IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                tooltip: 'Volver',
                icon: const Icon(Icons.arrow_back_rounded, size: 22),
              )
            : null,
        actions: actions,
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: body,
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}