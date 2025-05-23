import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';
import 'package:flutter_better_united/widgets/info_bubble.dart';
import 'package:flutter_better_united/widgets/input_field.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../data/model/team.dart';
import '../../figma/colors.dart';
import '../../util/Debouncer.dart';
import '../../widgets/empty_search_result.dart';
import '../../widgets/league_card_item.dart';
import 'create_profile_provider.dart';

class FavoriteClubsPage extends StatefulWidget {
  const FavoriteClubsPage({
    Key? key,
    this.favoriteTeamIds,
  }) : super(key: key);
  final List<int>? favoriteTeamIds;

  @override
  State<FavoriteClubsPage> createState() => _FavoriteClubsPageState();

  static Route route({List<int>? favoriteTeamIds}) {
    return CupertinoPageRoute(
      fullscreenDialog: false,
      builder: (_) => FavoriteClubsPage(
        favoriteTeamIds: favoriteTeamIds,
      ),
    );
  }
}

class _FavoriteClubsPageState extends State<FavoriteClubsPage> {
  late final ProfileProvider _profileProvider;

  @override
  void initState() {
    super.initState();
    _profileProvider = ProfileProvider(
        context.read(), context.read(), context.read(),
        favoriteTeamIds: widget.favoriteTeamIds);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _profileProvider,
      builder: (context, child) {
        return Scaffold(
          appBar: RegularAppBar.withBackButton(
              onBackTap: () {
                Navigator.of(context).pop();
              },
              title: "Favorite Clubs"),
          body: const Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InfoBubble(
                        description:
                        "Favourite club matches will be suggested to you."),
                  ],
                ),
              ),
              Expanded(
                child: FavoriteClubSelection(),
              ),
            ],
          ),
          bottomNavigationBar: const _BottomNavigation(),
        );
      },
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteTeamsCounter =
        context.watch<ProfileProvider>().userFavoriteTeamIds?.length ?? 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "clubSelectedArgs".plural(favoriteTeamsCounter),
          style: context.bodyMedium?.copyWith(color: AppColors.primary),
        ),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: PrimaryButton(
            onPressed: () async {
              await context.read<ProfileProvider>().addFavoriteTeams();
              Navigator.of(context).pop();
            },
            text: "Save changes",
          ),
        ),
      ],
    );
  }
}

class FavoriteClubSelection extends StatefulWidget {
  const FavoriteClubSelection({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteClubSelection> createState() => _FavoriteClubSelectionState();
}

class _FavoriteClubSelectionState extends State<FavoriteClubSelection> {
  final TextEditingController _textController = TextEditingController();
  late final _pagingController = PagingController<int, Team>(
    getNextPageKey: (state) => (state.keys?.last ?? 0) + 1,
    fetchPage: _fetchPage,
  );
  final _textDebouncer = Debouncer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pagingController.fetchNextPage();
    });
  }

  Future<List<Team>> _fetchPage(int pageKey) async {
    final profileProvider = context.read<ProfileProvider>();
    if (profileProvider.searchTerm.isEmpty) {
      await profileProvider.getTeams(
          pageNumber: pageKey, searchTerm: profileProvider.searchTerm);
    }
    return [Team(-1, "", "")];
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
    _textController.dispose();
    _textDebouncer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pagingState = context.watch<ProfileProvider>().pagingState;
    final profileProvider = context.read<ProfileProvider>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: InputField(
            isErrorTextVisible: false,
            controller: _textController,
            hintText: "searchFavoriteClubHint".tr(),
            prefixIcon: const Icon(BetterUnited.search),
            onChanged: (value) {
              if (value.isNotEmpty && value != profileProvider.searchTerm) {
                _textDebouncer.run(
                      () {
                    profileProvider.searchTerm = value;
                    profileProvider.searchTeam(value);
                  },
                );
              } else if (value.isEmpty && profileProvider.searchTerm.isNotEmpty) {
                profileProvider.searchTerm = "";
                _pagingController.fetchNextPage();
              }
            },
          ),
        ),
        Expanded(
          child: ((pagingState.pages?.isEmpty ?? true) && _textController.text.isNotEmpty && !(pagingState.isLoading ?? false))
              ? CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Center(
                  child: EmptySearchResult(
                    query: _textController.text,
                    text: "favoriteClubMatchNotFound".tr(),
                  ),
                ),
              )
            ],
          )
              : SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  height: 400,
                  child: Builder(
                    builder: (context) {
                      if ((pagingState.pages?.isEmpty ?? true) && (pagingState.isLoading ?? false)) {
                        return Center(
                          child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: 24,
                              width: 24,
                              child: const CircularProgressIndicator()),
                        );
                      }

                      final List<Team> allTeams = pagingState.items?.toList() ?? [];

                      return GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: allTeams.length + ((pagingState.hasNextPage ?? false) ? 1 : 0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.5,
                          crossAxisCount: 2,
                          mainAxisSpacing: 30.0,
                          crossAxisSpacing: 30.0,
                        ),
                        itemBuilder: (context, index) {
                          if (index == allTeams.length) {
                            if (!(pagingState.isLoading ?? true)) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                _pagingController.fetchNextPage();
                              });
                            }
                            
                            return Center(
                              child: Container(
                                margin: const EdgeInsets.all(15),
                                height: 30,
                                width: 30,
                                child: const CircularProgressIndicator(),
                              ),
                            );
                          }
                          
                          final item = allTeams[index];
                          return GestureDetector(
                            onTap: () {
                              context.read<ProfileProvider>().toggleTeam(item);
                            },
                            child: LeagueCard(
                              logoUrl: item.logoUrl,
                              teamName: item.name,
                              isSelected: item.isAddedToFavorite,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
