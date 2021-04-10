import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/plansApi.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChoosePlanDetailes extends StatefulWidget {
  final Plans plan;

  const ChoosePlanDetailes({Key key, @required this.plan}) : super(key: key);
  @override
  _ChoosePlanDetailesState createState() => _ChoosePlanDetailesState();
}

class _ChoosePlanDetailesState extends State<ChoosePlanDetailes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.plan.name),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.plan.name,
                style: AppTheme.heading.copyWith(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                '${widget.plan.newPrice} \$',
                style: AppTheme.heading.copyWith(fontSize: 20),
              ),
            ],
          ),
          SizedBox(height: 30),

          (widget.plan.features.isEmpty)
              ? contant()
              : ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: widget.plan.features.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        contant(title: widget.plan.features[index]),
                        SizedBox(height: 20),
                      ],
                    );
                  },
                ),
          // SizedBox(height: 20),
          // contant(title: 'قسم التعليم'),
          // SizedBox(height: 20),
          // contant(title: 'المدونة'),
          // SizedBox(height: 20),
          // contant(title: 'دورة خاصة في إدارة رأس المال'),
          // SizedBox(height: 20),
          // contant(title: 'مع الأستاذ أحمد'),
          // SizedBox(height: 20),
          // contant(title: 'فيديو في قسم ال Chart P'),
          // SizedBox(height: 50),
          // CustomButton(
          //   onPress: () {},
          //   text: 'اشترك',
          // )
        ],
      ),
    );
  }

  contant({String title}) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
          child: Center(
            child: Icon(
              FontAwesomeIcons.check,
              color: Colors.white,
              size: 10,
            ),
          ),
        ),
        SizedBox(width: 10),
        Text(
          title,
          style: AppTheme.heading.copyWith(
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
