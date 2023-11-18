import 'package:flutter/material.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton({
    super.key,
    required this.refresh,
  });
  final Function() refresh;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: refresh,
      child: Container(
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: const Icon(
          Icons.refresh_rounded,
          color: Colors.black,
          size: 35,
        ),
      ),
    );
  }
}
