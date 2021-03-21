import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/theBolg.dart';
import 'package:almosawii/secreens/theBlog/bolgDetailes.dart';
import 'package:flutter/material.dart';

class Blog extends StatefulWidget {
  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // toolbarHeight: 0,
          ),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          Text(
            'المدونة',
            style: AppTheme.heading.copyWith(color: customColor, fontSize: 20),
          ),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
            itemCount: blogList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BolgDetailes(
                        theBolg: blogList[index],
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(blogList[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: customCachedNetworkImage(
                            context: context,
                            url: blogList[index].image,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 180,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              blogList[index].date,
                              style: AppTheme.subHeading.copyWith(
                                color: customColorGray,
                                fontSize: 9,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                blogList[index].name,
                                style: AppTheme.heading.copyWith(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                blogList[index].contant,
                                style: AppTheme.subHeading.copyWith(
                                  color: customColorGray,
                                  fontSize: 9,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
