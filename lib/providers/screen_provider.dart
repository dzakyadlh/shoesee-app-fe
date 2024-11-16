import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'screen_provider.g.dart';

@riverpod
class ScreenNotifier extends _$ScreenNotifier {
  @override
  int build() {
    return 0; // Default currentIndex is 0
  }

  void setCurrentIndex(int index) {
    state = index; // Update the state with the new index
  }
}
