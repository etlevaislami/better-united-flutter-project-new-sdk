import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/enum/poule_type.dart';
import 'package:flutter_better_united/pages/tip/tip_provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'dart:async';
import 'package:visibility_detector/visibility_detector.dart';

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

class _TipListState extends State<TipList> with AutomaticKeepAliveClientMixin {
  late final TipProvider _tipProvider;
  PagingController<int, TipDetail>? _pagingController;
  bool _isDisposed = false;
  bool _isInitialized = false;
  Map<int, List<TipDetail>> _pageCache = {};
  Set<int> _ongoingRequests = {};
  Timer? _debounceTimer;
  int _totalPages = 0;
  bool _isLoading = false;
  bool _isVisible = true;
  final _visibilityKey = GlobalKey();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tipProvider = TipProvider(
      context.read(),
      context.read(),
      filterCriteria: widget.filterCriteria,
    );
    _createPagingController();
    _isInitialized = true;
  }

  void _createPagingController() {
    if (_isDisposed) return;

    if (_pagingController != null) {
      if (!_pagingController!.hasNextPage) {
        _pagingController?.dispose();
      }
      _pagingController = null;
    }

    if (!_isDisposed && mounted) {
      _pagingController = PagingController<int, TipDetail>(
        getNextPageKey: (state) {
          if (_isDisposed || !mounted || !_isVisible) return null;
          if (state.pages?.isEmpty ?? true) return 1;
          if (!state.hasNextPage) return null;
          final lastKey = state.keys?.last;
          if (lastKey != null && _totalPages > 0 && lastKey >= _totalPages) {
            return null;
          }
          return lastKey != null ? lastKey + 1 : 1;
        },
        fetchPage: (pageKey) async {
          if (_isDisposed || !mounted || !_isVisible || _isLoading) {
            return [];
          }

          if (_ongoingRequests.contains(pageKey)) {
            if (kDebugMode) {
              print('Request already in progress for page $pageKey');
            }
            return [];
          }

          if (_pageCache.containsKey(pageKey)) {
            if (kDebugMode) {
              print('Returning cached data for page $pageKey');
            }
            return _pageCache[pageKey] ?? [];
          }

          _debounceTimer?.cancel();

          try {
            _isLoading = true;
            _ongoingRequests.add(pageKey);

            await Future.delayed(const Duration(milliseconds: 300));
            if (_isDisposed || !mounted || !_isVisible) {
              return [];
            }

            final response = await _tipProvider.getTips(pageNumber: pageKey);

            if (_isDisposed || !mounted || !_isVisible) {
              return [];
            }

            if (response.isNotEmpty) {
              _totalPages = _tipProvider.pagingState.hasNextPage ? pageKey + 1 : pageKey;
            }

            _pageCache[pageKey] = response;

            if (kDebugMode) {
              print('Fetched page $pageKey with ${response.length} items');
            }

            return response;
          } catch (e) {
            if (kDebugMode) {
              print('Error fetching page $pageKey: $e');
            }
            rethrow;
          } finally {
            _ongoingRequests.remove(pageKey);
            _isLoading = false;
          }
        },
      );
    }
  }

  void _clearCache() {
    _pageCache.clear();
    _ongoingRequests.clear();
    _totalPages = 0;
  }

  @override
  void didUpdateWidget(TipList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isDisposed && mounted && _isVisible && widget.filterCriteria != oldWidget.filterCriteria) {
      _clearCache();
      _tipProvider.updateFilterCriteria(widget.filterCriteria);
      _createPagingController();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInitialized && !_isDisposed && mounted) {
      _isVisible = true;
      _createPagingController();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _isVisible = false;
    _debounceTimer?.cancel();
    _clearCache();
    if (_pagingController != null) {
      if (!_pagingController!.hasNextPage) {
        _pagingController?.dispose();
      }
      _pagingController = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_isDisposed || !mounted || _pagingController == null) {
      return const SizedBox();
    }

    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: (visibilityInfo) {
        if (!mounted || _isDisposed) return;

        final wasVisible = _isVisible;
        _isVisible = visibilityInfo.visibleFraction > 0;

        if (_isVisible && !wasVisible) {
          _createPagingController();
        }
      },
      child: _buildTipList(),
    );
  }

  Widget _buildTipList() {
    if (!mounted || _isDisposed || _pagingController == null) {
      return const SizedBox();
    }

    return ChangeNotifierProvider.value(
      value: _tipProvider,
      child: Consumer<TipProvider>(
        builder: (context, provider, child) {
          if (!mounted || _isDisposed || _pagingController == null) {
            return const SizedBox();
          }

          if (widget.withSliver) {
            return _buildPagedSliverList(provider.totalItemCount);
          }
          return widget.isRefreshEnabled
              ? RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: () async {
              if (_isDisposed || !mounted) return;
              await Future.microtask(() {});
              if (mounted && !_isDisposed) {
                _clearCache();
                _createPagingController();
              }
            },
            child: _buildPagedListView(provider.totalItemCount),
          )
              : _buildPagedListView(provider.totalItemCount);
        },
      ),
    );
  }

  Widget _buildPagedSliverList(int totalItemCount) {
    if (!mounted || _isDisposed || _pagingController == null) {
      return const SliverToBoxAdapter(child: SizedBox());
    }

    return MultiSliver(
      children: [
        SliverPinnedHeader(
          child: widget.displayResultCount
              ? ResultCounterWidget(count: totalItemCount)
              : const SizedBox(),
        ),
        PagingListener(
          controller: _pagingController!,
          builder: (context, state, fetchNextPage) {
            if (!mounted || _isDisposed) {
              return const SliverToBoxAdapter(child: SizedBox());
            }

            return PagedSliverList.separated(
              state: state,
              fetchNextPage: fetchNextPage,
              builderDelegate: PagedChildBuilderDelegate<TipDetail>(
                noItemsFoundIndicatorBuilder: (context) =>
                    Center(child: widget.emptyWidget ?? const SizedBox()),
                firstPageProgressIndicatorBuilder: (context) => Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 24,
                    width: 24,
                    child: const CircularProgressIndicator(),
                  ),
                ),
                newPageProgressIndicatorBuilder: (context) => Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    height: 24,
                    width: 24,
                    child: const CircularProgressIndicator(),
                  ),
                ),
                itemBuilder: _getTipBuilder(),
                invisibleItemsThreshold: 5,
              ),
              separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 16),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPagedListView(int totalItemCount) {
    if (!mounted || _isDisposed || _pagingController == null) {
      return const SizedBox();
    }

    return PagingListener(
      controller: _pagingController!,
      builder: (context, state, fetchNextPage) {
        if (!mounted || _isDisposed) {
          return const SizedBox();
        }

        return PagedListView.separated(
          state: state,
          fetchNextPage: fetchNextPage,
          scrollController: widget.scrollController,
          builderDelegate: PagedChildBuilderDelegate<TipDetail>(
            noItemsFoundIndicatorBuilder: (context) =>
            widget.emptyWidget ?? const SizedBox(),
            firstPageProgressIndicatorBuilder: (context) => Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                height: 24,
                width: 24,
                child: const CircularProgressIndicator(),
              ),
            ),
            newPageProgressIndicatorBuilder: (context) => Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                height: 24,
                width: 24,
                child: const CircularProgressIndicator(),
              ),
            ),
            itemBuilder: _getTipBuilder(),
            invisibleItemsThreshold: 5,
          ),
          padding: const EdgeInsets.only(bottom: 50),
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 16),
        );
      },
    );
  }

  ItemWidgetBuilder<TipDetail> _getTipBuilder() {
    return (context, tip, index) {
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
  }
}