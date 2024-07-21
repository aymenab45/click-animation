import 'package:flutter/material.dart';

class OnClickAnimation extends StatefulWidget {
  const OnClickAnimation({super.key});

  @override
  State<OnClickAnimation> createState() => _OnClickAnimationState();
}

class _OnClickAnimationState extends State<OnClickAnimation>
    with SingleTickerProviderStateMixin {
  double top = 300;
  double bottom = 0;
  double right = 0;
  double left = 130;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTapDown: (details) {
          _showTapPosition(context, details.localPosition);
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                top: top,
                left: left,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    color: Colors.deepPurple,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTapPosition(BuildContext context, Offset position) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect positionToScreen = RelativeRect.fromRect(
      Rect.fromPoints(
        position,
        position,
      ),
      Offset.zero & overlay.size,
    );

    showOverlay(context, positionToScreen);
  }

  void showOverlay(BuildContext context, RelativeRect positionToScreen) {
    final overlay = Overlay.of(context);

    OverlayEntry overlayEntry;
    setState(() {
      // Update the position without changing size
      left = positionToScreen.left;
      top = positionToScreen.top - 50;
      right = positionToScreen.right;
      bottom = positionToScreen.bottom;
      print(left);
      print(right);
    });
  }
}
