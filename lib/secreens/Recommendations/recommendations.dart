import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Recommendations extends StatefulWidget {
  @override
  _RecommendationsState createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('التوصيات'),
      ),
    );
  }
}
