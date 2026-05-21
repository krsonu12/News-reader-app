import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_reader_app/core/error/failures.dart';
import 'package:news_reader_app/feature/news/domain/usecases/clear_news_cache_usecase.dart';

import '../../helpers/mock_repository.dart';

void main() {
  late MockNewsRepository repo;
  late ClearNewsCacheUseCase useCase;

  setUpAll(registerFallbackValues);

  setUp(() {
    repo = MockNewsRepository();
    useCase = ClearNewsCacheUseCase(repo);
  });

  group('ClearNewsCacheUseCase', () {
    test('calls repository.clearCache once', () async {
      when(() => repo.clearCache()).thenAnswer((_) async {});

      await useCase();

      verify(() => repo.clearCache()).called(1);
    });

    test('completes without error on success', () async {
      when(() => repo.clearCache()).thenAnswer((_) async {});

      await expectLater(useCase(), completes);
    });

    test('propagates AppFailure when repository throws', () async {
      when(() => repo.clearCache()).thenThrow(const AppFailure('Disk full'));

      expect(
        () => useCase(),
        throwsA(
          isA<AppFailure>().having((f) => f.message, 'message', 'Disk full'),
        ),
      );
    });
  });
}
