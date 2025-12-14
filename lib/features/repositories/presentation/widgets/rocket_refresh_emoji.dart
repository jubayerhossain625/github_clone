import 'package:flutter/material.dart';

class RocketRefreshEmoji extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const RocketRefreshEmoji({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  State<RocketRefreshEmoji> createState() => _RocketRefreshEmojiState();
}

class _RocketRefreshEmojiState extends State<RocketRefreshEmoji>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _position;
  late Animation<double> _opacity;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _position = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(1.5, -2),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _opacity = Tween<double>(begin: 1, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });
    await widget.onRefresh();
    await _controller.forward();
    _controller.reset();
    setState(() {
      _isRefreshing = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main content with pull-to-refresh
        RefreshIndicator(
          onRefresh: _handleRefresh,
          child: widget.child,
        ),

        // Rocket emoji animation
        if (_isRefreshing)
          AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return FractionalTranslation(
                translation: _position.value,
                child: Opacity(
                  opacity: _opacity.value,
                  child: Align(
                    alignment: Alignment.center,
                    child: const Text(
                      '🚀',
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
