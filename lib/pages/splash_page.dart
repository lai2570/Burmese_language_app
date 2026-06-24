import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chin/main.dart' show HomePage;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/intro.mp4")
      ..initialize().then((_) {
        setState(() {
          _initialized = true;
        });
        _controller.play();
        _controller.setVolume(0.0);
      });

    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) _navigateToHome();
    });
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_initialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          else
            Container(color: const Color(0xFF667eea)),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Chin Chin Chinese",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(blurRadius: 10.0, color: Colors.black45, offset: Offset(2.0, 2.0)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "For Myanmar Learners",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    letterSpacing: 1.2,
                    shadows: const [
                      Shadow(blurRadius: 8.0, color: Colors.black45, offset: Offset(1.0, 1.0)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
