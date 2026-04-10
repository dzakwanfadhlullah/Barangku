import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final bool showBackButton;
  final Widget? bottomNavigationBar;
  final bool centerTitle;

  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.showBackButton = true,
    this.bottomNavigationBar,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(title!),
              centerTitle: centerTitle,
              automaticallyImplyLeading: showBackButton,
            )
          : null,
      body: SafeArea(child: body),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
