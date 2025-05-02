import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/enum/poule_type.dart';
import 'package:flutter_better_united/pages/tip/tip_provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:tuple/tuple.dart';

import '../../data/model/filter_criteria.dart';
import '../../data/model/tip.dart';
import '../../widgets/prediction_card.dart';
import '../../widgets/result_counter_widget.dart';

class TipList extends StatefulWidget {
  TipList({
    required this.filterCriteria,
    this.scrollController,
    this.isRefreshEnabled = false,
    this.emptyWidget,
    this.withSliver = false,
    this.displayResultCount = false,
    this.isFriendLeagueNameVisible = true,
    required this.pouleName,
    required this.pouleType,
    this.onProfileTap,
  }) : super(key: ObjectKey(filterCriteria));

  final FilterCriteria filterCriteria;
  final ScrollController? scrollController;
  final bool isRefreshEnabled;
  final bool withSliver;
  final Widget? emptyWidget;
  final bool displayResultCount;
  final bool isFriendLeagueNameVisible;
  final String pouleName;
  final PouleType pouleType;
  final Function(TipDetail)? onProfileTap;

  @override
  State<TipList> createState() => _TipListState();
}

class _TipListState extends State<TipList> {
  late final TipProvider _tipProvider;
  final _pagingController = PagingController<int, TipDetail>(
    firstPageKey: 1,
  );

  @override
  void initState() {
    super.initState();
    _tipProvider = TipProvider(
      context.read(),
      context.read(),
      filterCriteria: widget.filterCriteria,
    );
    _observePageChange();
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildTipList();
  }

  Widget _buildTipList() {
    return ChangeNotifierProvider(
      create: (context) => _tipProvider,
      child: Selector<TipProvider, Tuple2<PagingState<int, TipDetail>, int>>(
        selector: (p0, p1) => Tuple2(p1.pagingState, p1.totalItemCount),
        builder: (context, data, child) {
          final pagingState = data.item1;
          final totalItemCount = data.item2;
          if (widget.withSliver) {
            return _buildPagedSliverList(pagingState, totalItemCount);
          }
          return widget.isRefreshEnabled
              ? RefreshIndicator(
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  onRefresh: () => Future.sync(
                    () {
                      _tipProvider.refreshTips();
                    },
                  ),
                  child: _buildPagedListView(pagingState, totalItemCount),
                )
              : _buildPagedListView(pagingState, totalItemCount);
        },
      ),
    );
  }

  Widget _buildPagedSliverList(
      PagingState<int, TipDetail> pagingState, int totalItemCount) {
    return pagingState.status == PagingStatus.noItemsFound
        ? SliverFillRemaining(
            child: widget.emptyWidget,
          )
        : MultiSliver(
            children: [
              SliverPinnedHeader(
                  child: widget.displayResultCount
                      ? ResultCounterWidget(count: totalItemCount)
                      : const SizedBox()),
              PagedSliverList.separated(
                pagingController: _pagingController..value = pagingState,
                builderDelegate: PagedChildBuilderDelegate<TipDetail>(
                  noItemsFoundIndicatorBuilder: (context) =>
                      Center(child: widget.emptyWidget),
                  firstPageProgressIndicatorBuilder: (context) => Center(
                    child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 24,
                        width: 24,
                        child: const CircularProgressIndicator()),
                  ),
                  itemBuilder: _getTipBuilder(),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 16,
                ),
              ),
            ],
          );
  }

  Widget _buildPagedListView(
      PagingState<int, TipDetail> pagingState, int totalItemCount) {
    print(pagingState.itemList?.length);
    return PagedListView.separated(
      scrollController: widget.scrollController,
      builderDelegate: PagedChildBuilderDelegate<TipDetail>(
        newPageErrorIndicatorBuilder: (context) {
          return const SizedBox();
        },
        firstPageErrorIndicatorBuilder: (context) {
          return const SizedBox();
        },
        noItemsFoundIndicatorBuilder: (context) =>
            widget.emptyWidget ?? const SizedBox(),
        firstPageProgressIndicatorBuilder: (context) => Center(
          child: Container(
              margin: const EdgeInsets.only(top: 10),
              height: 24,
              width: 24,
              child: const CircularProgressIndicator()),
        ),
        itemBuilder: _getTipBuilder(),
      ),
      padding: const EdgeInsets.only(bottom: 50),
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 16,
      ),
      pagingController: _pagingController..value = pagingState,
    );
  }

  _observePageChange() {
    _pagingController.addPageRequestListener(
      (pageKey) {
        _tipProvider.getTips(pageNumber: pageKey);
      },
    );
  }

  ItemWidgetBuilder<TipDetail> revealableTipBuilder() => (context, tip, index) {
        return PredictionCard(
          tipSettlement: tip.tipSettlement,
          startsAt: tip.matchStartsAt,
          onProfileTap: () => widget.onProfileTap?.call(tip),
          rank: tip.userLevel,
          photoUrl: tip.userProfilePictureUrl,
          points: tip.points,
          pouleName: widget.pouleName,
          homeTeam: tip.homeTeam,
          awayTeam: tip.awayTeam,
          leagueName: tip.leagueName,
          createdAt: tip.tipCreatedAt,
          levelName: tip.userLevelName,
          name: tip.userNickname,
          odd: tip.hints,
          isConnectedUser: tip.isOwn,
          isVoided: tip.isTipVoided,
        );
      };


  ItemWidgetBuilder<TipDetail> _getTipBuilder() {
    return revealableTipBuilder();
  }
}
