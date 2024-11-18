import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DetailSkeleton extends StatelessWidget {
  const DetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          Colors.grey[800]!,
          Colors.grey[700]!,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Skeleton cho ảnh cover
            Container(
              width: MediaQuery.of(context).size.width,
              height: 345,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
