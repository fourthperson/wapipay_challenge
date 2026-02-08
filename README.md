# WapiPay Challenge

WapiPay Flutter Challenge Application.

## Project Structure

The project follows a Clean Architecture approach, separating concerns into Data, Domain, and Presentation layers.

```
lib/
├── data/           # Data layer: Repositories implementations, Data sources, DTOs
├── domain/         # Domain layer: Entities, Repository interfaces, Use cases
├── presentation/   # Presentation layer: UI, State management, Widgets
│   ├── generated/  # Generated code (e.g., assets)
│   ├── l10n/       # Localization files
│   ├── model/      # Presentation specific models
│   ├── navigation/ # Navigation configuration (AutoRoute)
│   ├── screen/     # Application screens
│   ├── theme/      # App theme and styling
│   ├── util/       # Utility classes
│   └── widget/     # Reusable widgets
├── di.dart         # Dependency Injection setup (GetIt)
└── main.dart       # Application entry point
```

### Data Layer Details

A mock API was used in `MockApiDataSource`. All Phone numbers used in the demo video are specified in there. The number
`254722000000` is used to simulate a network error

### Presentation Layer Details

#### Screens (`lib/presentation/screen/`)

This directory contains the main screens of the application, organized by feature. Each screen typically corresponds to
a full page in the app.

- **welcome**: The initial welcome screen.
- **login**: User authentication screen.
- **otp**: One-Time Password verification screen.
- **pin**: Security PIN entry.
- **home**: The main dashboard of the application.
- **country**: Country selection screen.
- **language**: Language selection screen.

#### Widgets (`lib/presentation/widget/`)

This directory houses reusable UI components used across multiple screens. These widgets help maintain consistency and
reduce code duplication.

- **app_bar.dart**: Custom application bar.
- **button.dart**: Standardized buttons.
- **text.dart**: Typography and text styles.
- **text_field.dart**: Input fields.
- **loader.dart**: Loading indicators.
- **keyboard.dart**: Custom keyboard implementations.
- **selector.dart**: Selection widgets (e.g., dropdowns).
- **alert_dialog.dart**: Custom dialogs and alerts.

## Packages Used

This project leverages several key packages to ensure scalability, maintainability, and a great user experience.

### Architecture & State Management

- **flutter_bloc**: For state management using the BLoC pattern.
- **get_it**: For dependency injection (Service Locator).
- **auto_route**: For declarative routing and navigation.
- **equatable**: For value equality comparisons.
- **freezed**: For code generation of immutable classes and unions.

### UI & Animations

- **animate_do**: For beautiful animations.
- **cached_network_image**: For loading and caching network images.
- **carousel_slider**: For image carousels.
- **modal_bottom_sheet**: For advanced modal bottom sheets.
- **pinput**: For Pin code input fields.
- **rflutter_alert**: For custom alerts and popups.
- **smooth_page_indicator**: For customizable page indicators.

### Utilities & Storage

- **flutter_secure_storage**: For secure storage of sensitive data.
- **logger**: For pretty logging.
- **phone_numbers_parser**: For parsing and formatting phone numbers.
- **url_launcher**: For launching URLs.

### Code Generation & Assets

- **build_runner**: For running code generation tasks.
- **flutter_gen**: For type-safe asset generation.
- **json_serializable**: For JSON serialization/deserialization.

