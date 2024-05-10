import 'package:flutter/material.dart';

class Avatar extends StatefulWidget {
  final double size;
  final String image;
  final EdgeInsets margin;

  const Avatar({
    Key? key,
    required this.image,
    this.size = 50,
    this.margin = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(widget.image),
          ),
        ),
      ),
    );
  }
}
