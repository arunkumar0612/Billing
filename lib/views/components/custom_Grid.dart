import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomGridDelegate extends SliverGridDelegate {
  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    return const SliverGridRegularTileLayout(crossAxisCount: 3, mainAxisStride: 430, crossAxisStride: 320, childCrossAxisExtent: 300, childMainAxisExtent: 330, reverseCrossAxis: true);
  }

  @override
  bool shouldRelayout(covariant SliverGridDelegate oldDelegate) {
    return true;
  }
}
