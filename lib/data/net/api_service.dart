import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_better_united/data/net/create_friend_league_response.dart';
import 'package:flutter_better_united/data/net/models/bet_info_response.dart';
import 'package:flutter_better_united/data/net/models/birthday_request.dart';
import 'package:flutter_better_united/data/net/models/bookie_maker_response.dart';
import 'package:flutter_better_united/data/net/models/coach_tip_response.dart';
import 'package:flutter_better_united/data/net/models/create_tip_request.dart';
import 'package:flutter_better_united/data/net/models/daily_rewards_response.dart';
import 'package:flutter_better_united/data/net/models/friend_poule_reward_response.dart';
import 'package:flutter_better_united/data/net/models/identifier_response.dart';
import 'package:flutter_better_united/data/net/models/invite_self_response.dart';
import 'package:flutter_better_united/data/net/models/language_request.dart';
import 'package:flutter_better_united/data/net/models/league_response.dart';
import 'package:flutter_better_united/data/net/models/match_response.dart';
import 'package:flutter_better_united/data/net/models/nickname_request.dart';
import 'package:flutter_better_united/data/net/models/offer_response.dart';
import 'package:flutter_better_united/data/net/models/paginated_response.dart';
import 'package:flutter_better_united/data/net/models/picture_response.dart';
import 'package:flutter_better_united/data/net/models/power_up_response.dart';
import 'package:flutter_better_united/data/net/models/profile_response.dart';
import 'package:flutter_better_united/data/net/models/public_poule_reward_response.dart';
import 'package:flutter_better_united/data/net/models/push_preference_request.dart';
import 'package:flutter_better_united/data/net/models/push_request.dart';
import 'package:flutter_better_united/data/net/models/ranking_overview_response.dart';
import 'package:flutter_better_united/data/net/models/rankings_response.dart';
import 'package:flutter_better_united/data/net/models/reward_level_response.dart';
import 'package:flutter_better_united/data/net/models/rewards_response.dart';
import 'package:flutter_better_united/data/net/models/self_invite_request.dart';
import 'package:flutter_better_united/data/net/models/single_video_response.dart';
import 'package:flutter_better_united/data/net/models/site_settings_response.dart';
import 'package:flutter_better_united/data/net/models/team_of_season_response.dart';
import 'package:flutter_better_united/data/net/models/team_of_week_response.dart';
import 'package:flutter_better_united/data/net/models/tip_created_response.dart';
import 'package:flutter_better_united/data/net/models/user_response.dart';
import 'package:flutter_better_united/data/net/models/verify_purchase_request.dart';
import 'package:flutter_better_united/data/net/models/video_category_response.dart';
import 'package:flutter_better_united/data/net/models/video_response.dart';
import 'package:retrofit/retrofit.dart';

import 'models/EventCategoryResponse.dart';
import 'models/active_poule_list_response.dart';
import 'models/add_favorite_teams_request.dart';
import 'models/auth_request.dart';
import 'models/auth_response.dart';
import 'models/create_friend_league_request.dart';
import 'models/delete_account_request.dart';
import 'models/forgot_password_request.dart';
import 'models/friend_league_active_list_item.dart';
import 'models/friend_league_detail_response.dart';
import 'models/friend_league_name_request.dart';
import 'models/friend_league_response.dart';
import 'models/friend_response.dart';
import 'models/matches_by_league_response.dart';
import 'models/public_league_detail_response.dart';
import 'models/public_league_join_info_response.dart';
import 'models/purchased_offer_response.dart';
import 'models/register_request.dart';
import 'models/reset_password_request.dart';
import 'models/teams_paginated_response.dart';
import 'models/tip_revealed_detail_response.dart';
import 'models/unacknowledged_poules_rewards_response.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/event/category/list")
  @Extra({'requiresToken': false})
  Future<List<EventCategoryResponse>> categoryList();

  @POST("/auth/login")
  @Extra({'requiresToken': false})
  Future<AuthResponse> login(@Body() AuthRequest request);

  @POST("/auth/forgot-password")
  @Extra({'requiresToken': false})
  Future forgotPassword(@Body() ForgotPasswordRequest request);

  @POST("/auth/reset-password/{id}/{token}")
  @Extra({'requiresToken': false})
  Future resetPassword(
    @Path("id") String id,
    @Path("token") String token,
    @Body() ResetPasswordRequest password,
  );

  @POST("/auth/register")
  @Extra({'requiresToken': false})
  Future<HttpResponse> register(@Body() RegisterRequest request);

  @GET("/user/profile")
  Future<ProfileResponse> getProfile();

  @PUT("/user/nickname")
  Future<HttpResponse> setNickname(@Body() NicknameRequest request);

  @PUT("/user/dateOfBirth")
  Future<HttpResponse> setBirthday(@Body() BirthdayRequest request);

  @DELETE("/user/profile")
  Future<HttpResponse> deleteProfile(@Body() DeleteAccountRequest request);

  @PUT("/user/language")
  Future<HttpResponse> setLanguage(@Body() LanguageRequest request);

  @MultiPart()
  @POST("/media/upload-picture")
  Future<PictureResponse> uploadProfilePicture(@Part(name: "file") File attach);

  @GET("/user/push-preference")
  Future<PushPreferenceRequest> getPushPreferences();

  @PUT("/user/push-preference")
  Future<HttpResponse> updatePushPreferences(
      @Body() PushPreferenceRequest request);

  @GET("/video")
  Future<List<VideoResponse>> getVideos(
    @Query("categoryId") int? categoryId,
  );

  @GET("/video-category")
  Future<List<VideoCategoryResponse>> getVideoCategory();

  @GET("/video")
  Future<List<VideoResponse>> getAllVideos();

  @GET("/video/{id}")
  Future<SingleVideoResponse> getVideo(@Path("id") int id);

  @POST("/video/like/{id}")
  Future likeVideo(@Path("id") int id);

  @POST("/video/unlike/{id}")
  Future unlikeVideo(@Path("id") int id);

  @GET("/powerup/list")
  Future<List<PowerUpResponse>> getPowerups();

  @POST("/shop/in-app-purchase")
  Future<HttpResponse> verifyPurchase(
      @Body() VerifyPurchaseRequest verifyPurchaseRequest);

  @POST("/shop/purchase-powerup/{id}")
  Future<HttpResponse> purchasePowerups(@Path("id") int id);

  @GET("/league/list")
  Future<List<LeagueResponse>> getLeagues(
      @Query("matchDayStart") String? matchDayStart,
      @Query("matchDayEnd") String? matchDayEnd,
      @Query("showAll") int showAll);

  @GET("/league/list-matches")
  Future<List<MatchesByLeagueResponse>> getMatches(
    @Query("matchDayStart") String? matchDayStart,
    @Query("matchDayEnd") String? matchDayEnd,
    @Query("publicLeagueId") int? publicLeagueId,
    @Query("searchTerm") String? searchTerm,
  );

  @GET("/league/{id}/list-matches")
  Future<List<MatchResponse>> getMatchesByLeague(
      @Path("id") int id,
      @Query("matchDayStart") String matchDayStart,
      @Query("matchDayEnd") String matchDayEnd);

  @POST("/tip/create")
  Future<TipCreatedResponse> createTip(@Body() CreateTipRequest request);

  @GET("/coach-tip/list")
  Future<List<CoachTipResponse>> getCoachTip();

  @GET("/tip/list")
  Future<PaginatedResponse> getTips(
      @Query("searchTerm") String? searchTerm,
      @Query("onlyFollowing") int? onlyFollowing,
      @Query("leagueId") int? leagueId,
      @Query("teamId") int? teamId,
      @Query("date") String? date,
      @Query("sortBy") String sortBy,
      @Query("page") int page,
      @Query("friendLeagueId") int? friendLeagueId,
      @Query("onlyFriendLeagues") int? onlyFriendLeagues,
      @Query("onlyActive") int? onlyActive,
      @Query("userId") int? userId,
      @Query("onlyHistory") int? onlyHistory,
      @Query("onlyMine") int? onlyMine,
      @Query("onlyOthers") int? onlyOthers,
      @Query("publicLeagueId") int? publicLeagueId);

  @GET("/tip/additional-bets/{tipId}")
  Future<List<BookieMakerResponse>> getAdditionalBets(@Path("tipId") int id);

  @GET("/tip/clickable-bets/{tipId}")
  Future<List<BookieMakerResponse>> getClickableBets(@Path("tipId") int id);

  @GET("/team/list")
  Future<TeamsPaginatedResponse> searchTeam(
    @Query("searchTerm") String? searchTerm,
    @Query("page") int page,
  );

  @POST("/tip/like/{id}")
  Future likeTip(@Path("id") int id);

  @POST("/tip/unlike/{id}")
  Future unlikeTip(@Path("id") int id);

  @POST("/tip/reveal/{id}")
  Future<HttpResponse> revealTip(@Path("id") int id);

  @POST("/user/follow/{id}")
  Future followUser(@Path("id") int id);

  @POST("/user/unfollow/{id}")
  Future unfollowUser(@Path("id") int id);

  @POST("/user/subscribe/{id}")
  Future subscribeUser(@Path("id") int id);

  @POST("/user/unsubscribe/{id}")
  Future unsubscribeUser(@Path("id") int id);

  @GET("/user/profile/{id}")
  Future<ProfileResponse> getOtherProfile(@Path("id") int id);

  @GET("/tip/details/{id}")
  Future<TipRevealedDetailResponse> getTipDetail(@Path("id") int id);

  @POST("/friends-league/create")
  Future<CreateFriendLeagueResponse> createFriendLeague(
      @Body() CreateFriendLeagueRequest request);

  @GET("/friends-league/list-friends")
  Future<List<FriendResponse>> getFriends();

  @GET("/user/list")
  Future<List<UserResponse>> getUsers(@Query("searchTerm") String? searchTerm);

  @GET("/friends-league/list-friends/{friendLeagueId}")
  Future<List<FriendResponse>> getFriendsByFriendLeagueId(
      @Path("friendLeagueId") int friendLeagueId);

  @POST("/friends-league/invite-friend/{leagueId}/{friendId}")
  Future inviteFriendToFriendLeague(
      @Path("leagueId") int leagueId, @Path("friendId") int friendId);

  @POST("/public-league/invite-friend/{leagueId}/{friendId}")
  Future inviteFriendToPublicLeague(
      @Path("leagueId") int leagueId, @Path("friendId") int friendId);

  @POST("/friends-league/invite-friend/{leagueId}/all")
  Future inviteAllFriendsToFriendLeague(@Path("leagueId") int leagueId);

  @POST("/public-league/invite-friend/{leagueId}/all")
  Future inviteAllFriendsToPublicLeague(@Path("leagueId") int leagueId);

  @POST("/friends-league/check-name")
  Future<HttpResponse> checkFriendLeagueName(
      @Body() FriendLeagueNameRequest request);

  @GET("/tip/list-bets/{matchId}")
  Future<BetInfoResponse> getFriendPouleOdds(
    @Path("matchId") int matchId,
    @Query("friendLeagueId") int friendLeagueId,
  );

  @GET("/tip/list-bets/{matchId}")
  Future<BetInfoResponse> getPublicPouleOdds(
    @Path("matchId") int matchId,
    @Query("publicLeagueId") int publicLeagueId,
  );

  @GET("/friends-league/list")
  Future<List<FriendLeagueResponse>> getFriendLeagues(
      @Query("baseLeagueId") int baseLeagueId,
      @Query("isFinished") int isFinished);

  @GET("/friends-league/list?isFinished=0")
  Future<List<FriendLeagueActivePouleItem>> getFriendPoules();

  @GET("/tip/list-unacknowledged")
  Future<List<IdentifierResponse>> getUnacknowledgedTips();

  @GET("/tip/rewards/{id}")
  Future<RewardsResponse> getRewards(@Path("id") int id);

  @POST("/tip/acknowledge-reward/{id}")
  Future acknowledgeTip(@Path("id") int id);

  @GET("/friends-league/{id}")
  Future<FriendLeagueDetailResponse> getFriendLeagueDetail(@Path("id") int id);

  @GET("/public-league/{id}")
  Future<PublicLeagueDetailResponse> getPublicLeagueDetail(@Path("id") int id);

  @POST("/user/push-token")
  Future<HttpResponse> updatePushToken(@Body() PushRequest request);

  @POST("/friends-league/accept-invite/{leagueId}")
  Future acceptFriendLeagueInvite(@Path("leagueId") int id);

  @POST("/public-league/accept-invite/{leagueId}")
  Future acceptPublicLeagueInvite(@Path("leagueId") int id);

  @POST("/friends-league/decline-invite/{leagueId}")
  Future declineFriendLeagueInvite(@Path("leagueId") int id);

  @POST("/public-league/decline-invite/{leagueId}")
  Future declinePublicLeagueInvite(@Path("leagueId") int id);

  @POST("/friends-league/invite-self")
  Future<InviteSelfResponse> inviteSelf(
      @Body() SelfInviteRequest selfInviteRequest);

  @GET("/reward/list")
  Future<List<RewardLevelResponse>> getLevelRewards();

  @POST("/reward/claim/{id}")
  Future<HttpResponse> claimReward(@Path("id") int id);

  @PUT("/user/favourite-teams")
  Future<HttpResponse> addFavoriteTeams(
      @Body() AddFavoriteTeamsRequest request);

  @GET("/active-poules/list")
  Future<ActivePouleListResponse> getActivePouleList();

  @DELETE("/active-poules/friend/{id}")
  Future<HttpResponse> removeFriendPoule(@Path("id") int pouleId);

  @DELETE("/active-poules/public/{id}")
  Future<HttpResponse> removePublicPoule(@Path("id") int pouleId);

  @GET("/public-league/list?isFinished=0")
  Future<List<PublicLeagueJoinInfoResponse>> getPublicPoules(
      @Query("joined") int joined);

  @POST("/public-league/join-public-league/{id}")
  Future<HttpResponse> joinPublicLeague(@Path("id") int id);

  @GET("/user/list-unacknowledged-poules-rewards")
  Future<UnacknowledgedPoulesRewardsResponse> getUnacknowledgedPoulesRewards();

  @GET("/user/poule/friend/rewards/{id}")
  Future<FriendPouleRewardResponse> getFriendPouleReward(@Path("id") int id);

  @GET("/user/poule/public/rewards/{id}")
  Future<PublicPouleRewardResponse> getPublicPouleReward(@Path("id") int id);

  @POST("/user/poule/public/acknowledge-reward/{id}")
  Future acknowledgePublicPouleReward(@Path("id") int id);

  @POST("/user/poule/friend/acknowledge-reward/{id}")
  Future acknowledgeFriendPouleReward(@Path("id") int id);

  @GET("/ranking/week/overview")
  Future<RankingOverviewResponse> getWeeklyRankingOverview();

  @GET("/ranking/seasonal/list")
  Future<RankingsResponse> getSeasonalRankings(@Query("page") int page);

  @GET("/ranking/seasonal/overview")
  Future<RankingOverviewResponse> getSeasonalRankingOverview();

  @GET("/ranking/week/list")
  Future<RankingsResponse> getWeeklyRankings(@Query("page") int page);

  @GET("/daily-reward/list")
  Future<DailyRewardsResponse> getDailyRewards();

  @POST("/daily-reward/claim")
  Future claimDailyReward();

  @GET("/ranking/team/week")
  Future<TeamOfWeekResponse> getTeamOfWeek();

  @GET("/ranking/team/seasonal")
  Future<TeamOfSeasonResponse> getTeamOfSeason();

  @POST("/ranking/claim/week")
  Future claimWeekRankingReward();

  @POST("/ranking/claim/seasonal")
  Future claimSeasonalRankingReward();

  @POST("/app-user/offer/purchase/{id}")
  Future purchaseOffer(@Path("id") int id);

  @POST("/app-user/offer/redeem/{id}")
  Future redeemCoupon(@Path("id") int id);

  @GET("/app-user/offer/{id}")
  Future<PurchasedOfferResponse> getPurchasedOfferById(@Path("id") int id);

  @GET("/offer/published")
  Future<List<OfferResponse>> getOffers();

  @GET("/app-user/offer?status=active")
  Future<List<PurchasedOfferResponse>> getActiveOffers();

  @GET("/app-user/offer?status=history")
  Future<List<PurchasedOfferResponse>> getRedeemedOffers();
}
