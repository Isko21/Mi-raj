import 'package:flutter/material.dart';
import 'properties.dart';

class MissPrayer extends StatelessWidget {
  const MissPrayer({
    Key? key,
    required this.title,
    required this.count,
    required this.minus,
    required this.plus,
  }) : super(key: key);

  final int count;
  final String title;
  final Function() plus;
  final Function() minus;

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
                onPressed: minus,
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
                onPressed: plus,
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
