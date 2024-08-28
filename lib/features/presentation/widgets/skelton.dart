
import 'package:flutter/material.dart';

class SkeltonLoading extends StatelessWidget {
  const SkeltonLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SkeltonContainer(
            height: 32,
            width: 32,
          ),
          SizedBox(
            width: 15,
          ),
          SkeltonContainer(height: 32, width: 290),
          SizedBox(
            width: 15,
          ),
          SkeltonContainer(height: 32, width: 50)
        ],
      ),
    );
  }
}

class SkeltonContainer extends StatelessWidget {
  final double height;
  final double width;
  const SkeltonContainer({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
