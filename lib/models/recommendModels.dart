class RecommendModels {
  final String title;
  final String date;
  final double stockNumber;
  final double stockRatio;
  final double entryPrice;
  final double checkOutPrice;
  final double lessLoss;
  final double biggestGain;

  RecommendModels({
    this.title,
    this.date,
    this.stockNumber,
    this.stockRatio,
    this.entryPrice,
    this.checkOutPrice,
    this.lessLoss,
    this.biggestGain,
  });
}

List<RecommendModels> recommendList = [
  RecommendModels(
    date: '12 مايو 2021',
    title: 'الذهب',
    stockNumber: 1784069.0,
    stockRatio: 2.47,
    entryPrice: 888,
    checkOutPrice: 44444,
    lessLoss: 1754.545,
    biggestGain: 154842.545,
  ),
  RecommendModels(
    date: '12 مايو 2021',
    title: 'LTC\\USD',
    stockNumber: 1784069.0,
    stockRatio: -2.47,
    entryPrice: 888,
    checkOutPrice: 44444,
    lessLoss: 1754.545,
    biggestGain: 154842.545,
  ),
  RecommendModels(
    date: '12 مايو 2021',
    title: 'الذهب',
    stockNumber: 1784069.0,
    stockRatio: 2.47,
    entryPrice: 888,
    checkOutPrice: 44444,
    lessLoss: 1754.545,
    biggestGain: 154842.545,
  ),
  RecommendModels(
    date: '12 مايو 2021',
    title: 'LTC\\USD',
    stockNumber: 1784069.0,
    stockRatio: -2.47,
    entryPrice: 888,
    checkOutPrice: 44444,
    lessLoss: 1754.545,
    biggestGain: 154842.545,
  ),
];
