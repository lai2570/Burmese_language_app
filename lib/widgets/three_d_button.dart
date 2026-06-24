import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../core/global_settings.dart';
import '../theme/app_durations.dart';

class ThreeDButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final BorderRadius borderRadius;
  final bool playSound;

  const ThreeDButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.borderRadius = BorderRadius.zero,
    this.playSound = true,
  });

  @override
  State<ThreeDButton> createState() => _ThreeDButtonState();
}

class _ThreeDButtonState extends State<ThreeDButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  final AudioPlayer _sfxPlayer = AudioPlayer();
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.buttonPress,
      reverseDuration: AppDurations.buttonRelease,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.90).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _sfxPlayer.dispose();
    super.dispose();
  }

  Future<void> _playClickSound() async {
    if (widget.playSound && widget.onPressed != null) {
      try {
        await _sfxPlayer.stop();
        await _sfxPlayer.play(AssetSource('audio/click.mp3'), volume: GlobalSettings.sfxVolume);
      } catch (e) {
        debugPrint("音效播放失敗: $e");
      }
    }
  }

  Future<void> _handleTap() async {
    if (widget.onPressed == null || _isAnimating) return;
    setState(() => _isAnimating = true);
    try {
      _playClickSound();
      await _controller.forward();
      await _controller.reverse();
      if (mounted) widget.onPressed!();
    } finally {
      if (mounted) setState(() => _isAnimating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: widget.borderRadius,
                  child: widget.child,
                ),
                if (_controller.value > 0)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: ClipRRect(
                        borderRadius: widget.borderRadius,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: const [0.0, 1.0],
                              colors: [
                                Colors.white.withOpacity(0.2 * _controller.value),
                                Colors.black.withOpacity(0.3 * _controller.value),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
