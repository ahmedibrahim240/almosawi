import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Rating {
  final String userName;
  final String userImage;
  final String comment;
  final double rate;

  Rating({this.userName, this.userImage, this.comment, this.rate});
}

List<Rating> ratingList = [
  Rating(
    userName: 'Ahmed ALMosawi',
    userImage: 'lib/images/ahmed.jpg',
    rate: 4.5,
    comment: 'يلا بلا بلا  بلا بلا  بلا  بلا  بلا بلا',
  ),
  Rating(
    userName: 'Ahmed ALMosawi',
    userImage: 'lib/images/ahmed.jpg',
    rate: 4.5,
    comment: 'يلا بلا بلا  بلا بلا  بلا  بلا  بلا بلا',
  ),
  Rating(
    userName: 'Ahmed ALMosawi',
    userImage: 'lib/images/ahmed.jpg',
    rate: 4.5,
    comment: 'يلا بلا بلا  بلا بلا  بلا  بلا  بلا بلا',
  ),
  Rating(
    userName: 'Ahmed ALMosawi',
    userImage: 'lib/images/ahmed.jpg',
    rate: 4.5,
    comment: 'يلا بلا بلا  بلا بلا  بلا  بلا  بلا بلا',
  ),
  Rating(
    userName: 'Ahmed ALMosawi',
    userImage: 'lib/images/ahmed.jpg',
    rate: 4.5,
    comment: 'يلا بلا بلا  بلا بلا  بلا  بلا  بلا بلا',
  ),
  Rating(
    userName: 'Ahmed ALMosawi',
    userImage: 'lib/images/ahmed.jpg',
    rate: 4.5,
    comment: 'يلا بلا بلا  بلا بلا  بلا  بلا  بلا بلا',
  ),
];
ratingListView({BuildContext context}) {
  return ListView.builder(
    shrinkWrap: true,
    primary: false,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    itemCount: ratingList.length,
    itemBuilder: (context, index) {
      return Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        ratingList[index].userImage,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ratingList[index].userName,
                      style: AppTheme.heading,
                    ),
                    RatingStar(
                      rating: ratingList[index].rate,
                    ),
                    Text(
                      ratingList[index].comment,
                      style: AppTheme.subHeading,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Divider(
              color: customColor.withOpacity(.4),
              thickness: 2,
            ),
          )
        ],
      );
    },
  );
}
