import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DetailSkeleton extends StatelessWidget {
  const DetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!, // Màu tối hơn cho dark theme
      highlightColor: Colors.grey[700]!,
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
