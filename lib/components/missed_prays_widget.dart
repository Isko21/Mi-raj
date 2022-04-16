import 'package:flutter/material.dart';

import 'properties.dart';

// ignore: must_be_immutable
class MissPrayer extends StatelessWidget {
  MissPrayer({
    Key? key,
    required this.title,
    required this.count,
    required this.minus,
    required this.plus,
  }) : super(key: key);

  int count;
  final String title;
  final Function plus;
  final Function minus;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 17, color: white),
          ),
          Row(
            children: [
              MaterialButton(
                color: color,
                shape: const CircleBorder(),
                onPressed: () => minus.call(),
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    '-',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
              Text(
                count.toString(),
                style: TextStyle(fontSize: 15, color: white),
              ),
              MaterialButton(
                color: color,
                shape: const CircleBorder(),
                onPressed: () => plus.call(),
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    '+',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
