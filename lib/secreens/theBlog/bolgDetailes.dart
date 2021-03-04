import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/theBolg.dart';
import 'package:flutter/material.dart';

class BolgDetailes extends StatefulWidget {
  final TheBolg theBolg;

  const BolgDetailes({Key key, @required this.theBolg}) : super(key: key);
  @override
  _BolgDetailesState createState() => _BolgDetailesState();
}

class _BolgDetailesState extends State<BolgDetailes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(widget.theBolg.image),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          ListView(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            children: [
              Text(
                widget.theBolg.name,
                style: AppTheme.heading,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'سعر السهم',
                    style: AppTheme.heading.copyWith(color: customColor),
                  ),
                  Text(
                    "58\$",
                    style: AppTheme.heading.copyWith(color: customColor),
                  ),
                ],
              ),
              Text(
                widget.theBolg.contant +
                    widget.theBolg.contant +
                    widget.theBolg.contant +
                    widget.theBolg.contant,
                style: AppTheme.heading,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
