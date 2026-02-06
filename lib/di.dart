part of 'main.dart';

final GetIt locator = GetIt.instance;

void initDi() {
  final Random random = Random();
  final Logger logger = Logger();

  final ApiDataSource apiDataSource = MockApiDataSource(
    random: random,
    logger: logger,
  );

  final CountryRepository countryRepository = CountryRepoImpl(
    apiDataSource: apiDataSource,
  );
  final AuthRepository authRepository = AuthRepositoryImpl(
    apiDataSource: apiDataSource,
  );

  locator.registerSingleton(
    CountryGetUseCase(countryRepository: countryRepository),
  );
  locator.registerSingleton(PhoneCheckUseCase(authRepository: authRepository));
  locator.registerSingleton(OtpVerifyUseCase(authRepository: authRepository));
}
