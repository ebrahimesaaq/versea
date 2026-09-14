import 'package:flutter/material.dart';

class EndReadingButton extends StatefulWidget {
  final VoidCallback onPressed;
  const EndReadingButton({super.key, required this.onPressed});

  @override
  State<EndReadingButton> createState() => _EndReadingButtonState();
}

class _EndReadingButtonState extends State<EndReadingButton>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  bool startAnimation = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        _startAnimation();
        await Future.delayed(Duration(milliseconds: 500));
        widget.onPressed();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: startAnimation
                ? ScaleTransition(
                    scale: _animation,
                    child: CustomPaint(
                      painter: CheckPainter(animation: _animation, scale: 0.7),
                      size: Size(20, 20),
                    ),
                  )
                : Icon(Icons.bookmark_border),
            //
          ),
          Text('حفظ القراءة'),
        ],
      ),
    );
  }

  void _startAnimation() async {
    setState(() {
      startAnimation = true;
    });
    _controller.reset();
    await _controller.forward();
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    setState(() {
      startAnimation = false;
    });
  }
}

class CheckPainter extends CustomPainter {
  final Animation animation;
  final double? scale;
  CheckPainter({required this.animation, this.scale})
    : super(repaint: animation);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    final path = Path();
    canvas.scale(scale ?? 1);
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(scale ?? 1);
    canvas.translate(-size.width / 2, -size.height / 2);
    paint.strokeWidth = 4;
    paint.style = PaintingStyle.stroke;
    paint.color = Colors.green;
    paint.strokeCap = StrokeCap.round;
    path.moveTo(10, 20);
    path.lineTo(20, 30);
    path.lineTo(40, 10);

    final metrics = path.computeMetrics().first;

    final currentPath = metrics.extractPath(
      0,
      metrics.length * animation.value,
    );
    canvas.drawPath(currentPath, paint);
  }

  @override
  bool shouldRepaint(covariant CheckPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}
