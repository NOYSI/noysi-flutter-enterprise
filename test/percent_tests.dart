// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

double _calcProgress({
  required int currentUploaded,
  required int currentSize,
  required int currentIndex,
  required int itemsCount,
}) {
  final currentProgress = currentUploaded / currentSize;
  final double rangesPercent = 1 / itemsCount;
  final double currentRangePercent = currentIndex * rangesPercent;
  final double currentItemPercent = currentProgress * rangesPercent;
  final double totalFinal = currentItemPercent + currentRangePercent;

  print("currentUploaded: $currentUploaded");
  print("total: $currentSize");
  print("currentIndex: $currentIndex");
  print("itemsCount: $itemsCount");
  print("currentProgress: $currentProgress");
  print("rangesPercent: $rangesPercent");
  print("currentRangePercent: $currentRangePercent");
  print("currentItemPercent: $currentItemPercent");
  print("totalFinal: $totalFinal");

  return totalFinal;
}

void main() {
  test('testing progress 1 item', () {
    expect(
      _calcProgress(
        currentUploaded: 5,
        currentSize: 10,
        currentIndex: 0,
        itemsCount: 1,
      ),
      0.5,
    );
    expect(
      _calcProgress(
        currentUploaded: 9,
        currentSize: 12,
        currentIndex: 0,
        itemsCount: 1,
      ),
      0.75,
    );
  });
  test('testing progress 2 item', () {
    expect(
      _calcProgress(
        currentUploaded: 5,
        currentSize: 10,
        currentIndex: 0,
        itemsCount: 2,
      ),
      0.25,
    );
    expect(
      _calcProgress(
        currentUploaded: 10,
        currentSize: 10,
        currentIndex: 0,
        itemsCount: 2,
      ),
      0.5,
    );
    expect(
      _calcProgress(
        currentUploaded: 0,
        currentSize: 10,
        currentIndex: 1,
        itemsCount: 2,
      ),
      0.5,
    );
    expect(
      _calcProgress(
        currentUploaded: 5,
        currentSize: 10,
        currentIndex: 1,
        itemsCount: 2,
      ),
      0.75,
    );
  });
  test('testing progress 3 item', () {
    // expect(
    //   _calcProgress(
    //     currentUploaded: 5,
    //     currentSize: 10,
    //     currentIndex: 0,
    //     itemsCount: 3,
    //   ),
    //   0.166666666, //the value is periodic
    // );
    expect(
      _calcProgress(
        currentUploaded: 5,
        currentSize: 10,
        currentIndex: 1,
        itemsCount: 3,
      ),
      0.5,
    );
  });
}