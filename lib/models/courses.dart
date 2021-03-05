class Courses {
  final String title;
  final String lecTitle;
  final String contant;
  final String image;
  final String badge;
  final List<CourseContent> coursContentList;
  final double rate;
  final double oldPrice;
  final double newPrice;

  Courses({
    this.image,
    this.coursContentList,
    this.badge,
    this.title,
    this.lecTitle,
    this.contant,
    this.rate,
    this.oldPrice,
    this.newPrice,
  });
}

List<Courses> coursesList = [
  Courses(
    coursContentList: courseContentList,
    badge: 'Bestseller',
    title: 'ساسيات الفوركس',
    contant:
        'الإدارة الصحيحة هي التي تجعل المتداول يتفوق في كل الأسواق الإدارة الصحيحة هي التي تجعل المتداول يتفوق في كل الأسواق الإدارة الصحيحة هي التي تجعل المتداول يتفوق في كل الأسواق ',
    lecTitle: 'Ryan Kroonenburg',
    image:
        'https://blog.roboforex.com/wp-content/uploads/2019/10/upravlenie-kapitalom-na-foreks_osnovnye-pravila-i-princzipy.png',
    rate: 5.0,
    newPrice: 49.99,
    oldPrice: 55.99,
  ),
  Courses(
    coursContentList: courseContentList,
    badge: 'Recent',
    title: 'إدارة رأس المال',
    contant:
        'الإدارة الصحيحة هي التي تجعل المتداول يتفوق في كل الأسواق الإدارة الصحيحة هي التي تجعل المتداول يتفوق في كل الأسواق الإدارة الصحيحة هي التي تجعل المتداول يتفوق في كل الأسواق ',
    lecTitle: 'Ryan Kroonenburg',
    image:
        'https://i1.wp.com/www.amnaymag.com/wp-content/uploads/2020/03/%D9%85%D8%A7-%D9%87%D9%88-%D8%A7%D9%84%D9%81%D9%88%D8%B1%D9%83%D8%B3-%D8%A8%D8%A8%D8%B3%D8%A7%D8%B7%D8%A9%D8%9F-%D8%A3%D8%B3%D8%A7%D8%B3%D9%8A%D8%A7%D8%AA-%D9%88%D8%AD%D9%82%D8%A7%D8%A6%D9%82-%D8%B9%D9%86-%D8%B3%D9%88%D9%82-%D8%B5%D8%B1%D9%81-%D8%A7%D9%84%D8%B9%D9%85%D9%84%D8%A7%D8%AA.jpg?ssl=1',
    rate: 4.5,
    newPrice: 49.99,
    oldPrice: 55.99,
  ),
  Courses(
    title: 'إدارة رأس المال',
    coursContentList: courseContentList,
    badge: 'Sale',
    contant:
        'الإدارة الصحيحة هي التي تجعل المتداول يتفوق في كل الأسواق الإدارة الصحيحة هي التي تجعل المتداول يتفوق في كل الأسواق الإدارة الصحيحة هي التي تجعل المتداول يتفوق في كل الأسواق ',
    lecTitle: 'Ryan Kroonenburg',
    image: 'https://i.ytimg.com/vi/50hug7EJubY/hqdefault.jpg',
    rate: 3.5,
    newPrice: 49.99,
    oldPrice: 55.99,
  ),
  Courses(
    title: 'إدارة رأس المال',
    coursContentList: courseContentList,
    badge: 'Bestseller',
    contant:
        'الإدارة الصحيحة هي التي تجعل المتداول يتفوق في كل الأسواق الإدارة الصحيحة هي التي تجعل المتداول يتفوق في كل الأسواق الإدارة الصحيحة هي التي تجعل المتداول يتفوق في كل الأسواق ',
    lecTitle: 'Ryan Kroonenburg',
    image: 'https://i.ytimg.com/vi/50hug7EJubY/hqdefault.jpg',
    rate: 4.6,
    newPrice: 49.99,
    oldPrice: 55.99,
  ),
  Courses(
    title: 'ساسيات الفوركس',
    coursContentList: courseContentList,
    badge: 'Sale',
    contant:
        'الإدارة الصحيحة هي التي تجعل المتداول يتفوق في كل الأسواق الإدارة الصحيحة هي التي تجعل المتداول يتفوق في كل الأسواق الإدارة الصحيحة هي التي تجعل المتداول يتفوق في كل الأسواق ',
    lecTitle: 'Ryan Kroonenburg',
    image:
        'https://images.pexels.com/photos/270366/pexels-photo-270366.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    rate: 2.0,
    newPrice: 49.99,
    oldPrice: 55.99,
  ),
  Courses(
    title: 'ساسيات الفوركس',
    coursContentList: courseContentList,
    badge: 'Recent',
    contant:
        'الإدارة الصحيحة هي التي تجعل المتداول يتفوق في كل الأسواق الإدارة الصحيحة هي التي تجعل المتداول يتفوق في كل الأسواق الإدارة الصحيحة هي التي تجعل المتداول يتفوق في كل الأسواق ',
    lecTitle: 'Ryan Kroonenburg',
    image:
        'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    rate: 4.0,
    newPrice: 49.99,
    oldPrice: 55.99,
  ),
];

class CourseContent {
  final String name;
  final String description;

  CourseContent({this.name, this.description});
}

List<CourseContent> courseContentList = [
  CourseContent(
    name: 'الفصل الاول',
    description: 'اسباب خصاره راس المال كي تضع لها حدا ',
  ),
  CourseContent(
    name: 'الفصل الثاني',
    description: 'لطريقة الصحيحة لبناء موع التداول وإد ',
  ),
  CourseContent(
    name: 'الفصل الثالث',
    description: 'اسباب خصاره راس المال كي تضع لها حدا ',
  ),
  CourseContent(
    name: 'الفصل الرابع',
    description: 'لطريقة الصحيحة لبناء موع التداول وإد ',
  ),
];
