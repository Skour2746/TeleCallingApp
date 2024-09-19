import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Homescreen extends StatefulWidget {
  static const String routeName = '/home-screen';

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calling App Onboarding',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;
  late VideoPlayerController _videoController1;
  late VideoPlayerController _videoController2;
  late VideoPlayerController _videoController3;

  @override
  void initState() {
    super.initState();

    // Initialize the video controllers
    _videoController1 = VideoPlayerController.asset('assets/animation1.mp4')
      ..initialize().then((_) {
        setState(() {}); // Update UI when the video is loaded
      });

    _videoController2 = VideoPlayerController.asset('assets/animation2.mp4')
      ..initialize().then((_) {
        setState(() {});
      });

    _videoController3 = VideoPlayerController.asset('assets/animation3.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    // Dispose of the controllers when the screen is closed
    _videoController1.dispose();
    _videoController2.dispose();
    _videoController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    isLastPage = index == 2;
                  });
                },
                children: [
                  buildOnboardingPage(
                    videoController: _videoController1,
                    title: 'Seamless Calling',
                    description:
                        'Make crystal-clear voice and video calls anywhere in the world.',
                  ),
                  buildOnboardingPage(
                    videoController: _videoController2,
                    title: 'Stay Connected',
                    description:
                        'Stay connected with your loved ones with just one tap.',
                  ),
                  buildOnboardingPage(
                    videoController: _videoController3,
                    title: 'Secure Conversations',
                    description:
                        'All your conversations are private and secured with end-to-end encryption.',
                  ),
                ],
              ),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.blueAccent,
                dotHeight: 8,
                dotWidth: 16,
              ),
            ),
            SizedBox(height: 20),
            isLastPage
                ? ElevatedButton(
                    onPressed: () {
                      // Navigate to home or main screen
                    },
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Colors.blueAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget buildOnboardingPage({
    required VideoPlayerController videoController,
    required String title,
    required String description,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 250,
          child: videoController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: videoController.value.aspectRatio,
                  child: VideoPlayer(videoController),
                )
              : CircularProgressIndicator(),
        ),
        SizedBox(height: 40),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
