import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_better_united/data/enum/poule_type.dart';
import 'package:flutter_better_united/data/model/league_detail.dart';
import 'package:flutter_better_united/pages/create_prediction/pages/choose_prediction_page.dart';
import 'package:flutter_better_united/pages/create_prediction/pages/overview_page.dart';
import 'package:flutter_better_united/pages/create_prediction/pages/select_poule_page.dart';
import 'package:provider/provider.dart';

import 'create_prediction_provider.dart';
import 'pages/choose_match_page.dart';

class CreatePredictionPage extends StatefulWidget {
  const CreatePredictionPage({super.key, this.poule, required this.pouleType});

  final LeagueDetail? poule;
  final PouleType pouleType;

  @override
  State<CreatePredictionPage> createState() => _CreatePredictionPageState();

  static Route route({LeagueDetail? poule, required PouleType pouleType}) {
    return CupertinoPageRoute(
      fullscreenDialog: true,
      builder: (_) => CreatePredictionPage(
        poule: poule,
        pouleType: pouleType,
      ),
    );
  }
}

class _CreatePredictionPageState extends State<CreatePredictionPage> {
  late final StreamSubscription _subscription;
  late final CreatePredictionProvider _createPredictionProvider;
  late Map<CreatePredictionStep, Widget> _pagesMap;
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    _pagesMap = {
      CreatePredictionStep.selectPrediction: const ChoosePredictionPage(),
      CreatePredictionStep.overview: const OverviewPage()
    };
    final poule = widget.poule;
    if (poule == null) {
      switch (widget.pouleType) {
        case PouleType.public:
          _pagesMap = {
            CreatePredictionStep.selectPoule:
                SelectPoulePage(pouleType: widget.pouleType),
            CreatePredictionStep.selectMatch: const ChooseMatchPage(),
            ..._pagesMap
          };
          break;
        case PouleType.friend:
          _pagesMap = {
            CreatePredictionStep.selectPoule:
                SelectPoulePage(pouleType: widget.pouleType),
            ..._pagesMap
          };
          break;
      }
    } else {
      if (poule.isPublicLeague) {
        final matches = poule.publicPouleData?.matches.length ?? 0;
        if ((matches) > 1 || matches == 0) {
          _pagesMap = {
            CreatePredictionStep.selectMatch: const ChooseMatchPage(),
            ..._pagesMap
          };
        }
      }
    }

    _createPredictionProvider = CreatePredictionProvider(
        context.read(), context.read(),
        steps: _pagesMap.keys.toList(), poule: widget.poule);
    _subscription =
        _createPredictionProvider.redirectionSubject.listen((event) {
      _controller.animateToPage(
        _pagesMap.keys.toList().indexOf(event),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _createPredictionProvider,
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: _pagesMap.values.toList(),
      ),
    );
  }
}
