import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvStatus usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchlistTvStatus(mockTvRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    final tId = 1;
    when(mockTvRepository.isAddedToWatchlist(tId))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, true);
  });
}