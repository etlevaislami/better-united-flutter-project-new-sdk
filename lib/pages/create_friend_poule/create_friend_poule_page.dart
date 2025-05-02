import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/pages/create_friend_poule/create_friend_poule_provider.dart';
import 'package:flutter_better_united/pages/create_friend_poule/pages/rules_page.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:provider/provider.dart';

import 'pages/choose_match_page.dart';
import 'pages/friend_poule_name_and_prize.dart';

class CreateFriendPoulePage extends StatefulWidget {
  const CreateFriendPoulePage({super.key});

  @override
  State<CreateFriendPoulePage> createState() => _CreateFriendPoulePageState();

  static Route route() {
    return CupertinoPageRoute(
        fullscreenDialog: false, builder: (_) => const CreateFriendPoulePage());
  }
}

class _CreateFriendPoulePageState extends State<CreateFriendPoulePage> {
  late final CreateFriendPouleProvider _createFriendPouleProvider;
  final PageController _controller = PageController();
  late final List<Widget> _pages;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _createFriendPouleProvider =
        CreateFriendPouleProvider(context.read(), context.read());
    _createFriendPouleProvider.redirectionSubject.listen((event) async {
      FocusScope.of(context).requestFocus(FocusNode());
      _controller.animateToPage(
        event.index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    });

    if (_createFriendPouleProvider.getFriendPouleRulesVisibilityOptions()) {
      _pages = [
        const RulesPage(),
        const ChooseMatchPage(),
        const FriendPouleNameAndPrize(),
      ];
    } else {
      _pages = [
        const ChooseMatchPage(),
        const FriendPouleNameAndPrize(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: RegularAppBar.withBackButton(
        title: "friendsPoule".tr(),
        onBackTap: () {
          if (_createFriendPouleProvider.activeStepIndex == 0) {
            context.pop();
          } else {
            _createFriendPouleProvider.onBackClicked();
          }
        },
        onCloseTap: () {
          context.pop();
        },
      ),
      body: ChangeNotifierProvider(
        create: (context) => _createFriendPouleProvider,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _controller,
          children: _pages,
        ),
      ),
    );
  }
}
