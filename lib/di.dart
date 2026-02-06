part of 'main.dart';

final GetIt locator = GetIt.instance;

void initDi() {
  final Random random = Random();
  final Logger logger = Logger();

  final LocalDataSource localDataSource = SecureLocalDataSource(logger: logger);
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
  final UserRepository userRepository = UserRepositoryImpl(
    localDataSource: localDataSource,
  );

  locator.registerSingleton(
    CountryGetUseCase(countryRepository: countryRepository),
  );
  locator.registerSingleton(PhoneCheckUseCase(authRepository: authRepository));
  locator.registerSingleton(OtpVerifyUseCase(authRepository: authRepository));
  locator.registerSingleton(UserSetUseCase(userRepository: userRepository));
  locator.registerSingleton(UserGetUseCase(userRepository: userRepository));
  locator.registerSingleton(UserClearUseCase(userRepository: userRepository));
}
