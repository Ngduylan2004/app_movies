import 'package:flutter/material.dart';

class NewfeedBannerWidget extends StatelessWidget {
  const NewfeedBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(36),
          child: Image.asset('assets/images/home/home_banner.png'),
        ),
        Positioned(
          left: 10,
          bottom: 10,
          child: Stack(
            children: [
              Container(
                width: 250,
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Positioned(
                left: 20,
                top: 10,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/home/icon/Icon.png',
                      width: 53,
                      height: 53,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Continue Watching',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xffBCBCBC),
                          ),
                        ),
                        Text(
                          'Ready Player One',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
