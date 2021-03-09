String recommContant =
    'الاتجاه العام صاعد بعد الصعود للاهداف الان تصحيح . يمكن الدخول الشراء ';
String stockImage =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQBnBdQcc0OvEF5F3_gWY1WepbKLFW7EbkLg&usqp=CAU';

class RecommendModels {
  final String title;
  final String date;
  final String contant;
  final String image;
  final double stockNumber;
  final double stockRatio;
  final double entryPrice;
  final double checkOutPrice;
  final double lessLoss;
  final double biggestGain;

  RecommendModels({
    this.contant,
    this.title,
    this.date,
    this.image,
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
    contant: recommContant,
    image: stockImage,
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
    contant: recommContant,
    image: stockImage,
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
    contant: recommContant,
    image: stockImage,
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
    contant: recommContant,
    image: stockImage,
  ),
];
