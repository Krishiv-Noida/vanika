import 'package:flutter/material.dart';

/// 3D Tilt Card with dynamic perspective matrix and specular glare reflection
/// Replicates the Framer Motion 3D card physics from web-ui/components/3d/Card3D.tsx
class Card3D extends StatefulWidget {
  final Widget child;
  final double maxTilt;
  final bool enableGlare;
  final double scale;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const Card3D({
    super.key,
    required this.child,
    this.maxTilt = 0.15, // Max radians
    this.enableGlare = true,
    this.scale = 1.02,
    this.borderRadius,
    this.onTap,
  });

  @override
  State<Card3D> createState() => _Card3DState();
}

class _Card3DState extends State<Card3D> with SingleTickerProviderStateMixin {
  late AnimationController _springController;
  late Animation<double> _tiltXAnim;
  late Animation<double> _tiltYAnim;

  double _tiltX = 0.0;
  double _tiltY = 0.0;
  Offset _glarePos = const Offset(0.5, 0.5);
  bool _isInteracting = false;

  @override
  void initState() {
    super.initState();
    _springController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
  }

  @override
  void dispose() {
    _springController.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details, Size size) {
    if (size.width == 0 || size.height == 0) return;
    final local = details.localPosition;
    final normX = (local.dx / size.width - 0.5).clamp(-0.5, 0.5);
    final normY = (local.dy / size.height - 0.5).clamp(-0.5, 0.5);

    setState(() {
      _isInteracting = true;
      _tiltX = normY * widget.maxTilt; // Pitch
      _tiltY = -normX * widget.maxTilt; // Roll
      _glarePos = Offset(
        (local.dx / size.width).clamp(0.0, 1.0),
        (local.dy / size.height).clamp(0.0, 1.0),
      );
    });
  }

  void _onPanEnd() {
    final startX = _tiltX;
    final startY = _tiltY;

    _tiltXAnim = Tween<double>(begin: startX, end: 0.0).animate(
      CurvedAnimation(parent: _springController, curve: Curves.easeOutBack),
    );
    _tiltYAnim = Tween<double>(begin: startY, end: 0.0).animate(
      CurvedAnimation(parent: _springController, curve: Curves.easeOutBack),
    );

    _springController.reset();
    _springController.forward();

    _springController.addListener(_springListener);
  }

  void _springListener() {
    setState(() {
      _tiltX = _tiltXAnim.value;
      _tiltY = _tiltYAnim.value;
      if (_springController.isCompleted) {
        _isInteracting = false;
        _springController.removeListener(_springListener);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadius ?? BorderRadius.circular(24);

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardSize = Size(constraints.maxWidth, constraints.maxHeight);

        final s = _isInteracting ? widget.scale : 1.0;
        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.0014) // Perspective focal depth
          ..rotateX(_tiltX)
          ..rotateY(_tiltY)
          ..scaleByDouble(s, s, 1.0, 1.0);

        return GestureDetector(
          onTap: widget.onTap,
          onPanDown: (_) => setState(() => _isInteracting = true),
          onPanUpdate: (details) => _onPanUpdate(details, cardSize),
          onPanEnd: (_) => _onPanEnd(),
          onPanCancel: () => _onPanEnd(),
          child: Transform(
            transform: transform,
            alignment: FractionalOffset.center,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: radius,
                boxShadow: [
                  BoxShadow(
                    color: _isInteracting
                        ? const Color(0x99041811)
                        : const Color(0x40020B06),
                    blurRadius: _isInteracting ? 28 : 12,
                    offset: Offset(0, _isInteracting ? 16 : 6),
                    spreadRadius: _isInteracting ? 2 : 0,
                  ),
                  if (_isInteracting)
                    const BoxShadow(
                      color: Color(0x334ADE80),
                      blurRadius: 18,
                      offset: Offset(0, 0),
                    ),
                ],
              ),
              child: ClipRRect(
                borderRadius: radius,
                child: Stack(
                  children: [
                    widget.child,

                    // Specular Glare Reflection Layer
                    if (widget.enableGlare && _isInteracting)
                      Positioned.fill(
                        child: IgnorePointer(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                center: Alignment(
                                  _glarePos.dx * 2 - 1,
                                  _glarePos.dy * 2 - 1,
                                ),
                                radius: 0.85,
                                colors: const [
                                  Color(0x3386EFAC),
                                  Color(0x1086EFAC),
                                  Colors.transparent,
                                ],
                                stops: const [0.0, 0.45, 1.0],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
