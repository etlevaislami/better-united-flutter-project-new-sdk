enum TipSettlement { notStarted, undetermined, lost, won }

int tipSettlementFromInt(TipSettlement value) => value.index;

TipSettlement intToTipSettlement(int? index) {
  if (index == 1) {
    return TipSettlement.lost;
  }

  if (index == 2) {
    return TipSettlement.won;
  }

  return TipSettlement.undetermined;
}
