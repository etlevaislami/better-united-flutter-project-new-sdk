String mapLevelNameToKey(String levelName) {
  switch (levelName.toUpperCase()) {
    case 'CLUB LEGEND':
      return 'level.club_legend';
    case 'STAR PLAYER':
      return 'level.star_player';
    case 'SUPERSUB':
      return 'level.super_sub';
    case 'BENCH PLAYER':
      return 'level.bench_player';
    case 'STARTING 11':
      return 'level.starting_11';
    case 'GRAND STAND':
      return 'level.grand_stand';
    default:
      return levelName;
  }
}
