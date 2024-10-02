# Project structure

++ "main.dart"
++ "app.dart"
++ "service_locator.dart"
++ "firebase_options.dart"

- core: common use in app
  - configs: when using library that need config (go_router, dio, shared_preferences...)
    - dio: eg interceptor for call API
    - shared_preferences: simple local storage
    - themes
      ++ "app_colors.dart"
      ++ "app_sizes.dart" default size
      ++ "app_theme.dart": contain light-dark theme config
      ++ "app_theme_extension.dart": see "ThemeExtension"
    - routes
      ++ "app_router.dart" see GoRouter
    - localizations
      ++ "app_localization.dart" support other language
  - constant
    - assets
      ++ "app_images.dart"
      ++ "app_vectors.dart"
    - urls
      ++ "app_urls.dart"
      ++ "{feature}_urls.dart"
    - enums
      ++ "app_enums.dart"
      ++ "{feature}_enums.dart"
  - usecase: base usecase abstract
  - helpers
  - extension
    ++ app_validator.dart: eg extension on String to validate email, extension on BuildContext to check ThemeMode
- presentation: contain UI
  - widgets: common/custom widgets for entire app
    ++ "appbar.dart"
    - buttons
    - textfields...
  - {feature} e.g: auth
    - bloc: logic of screens
    - screens:
      ++ "login_screen.dart" --(when login & register both in a screen >> login_register_screen)
      ++ "register_screen.dart"
    - widgets: small/separated widget of this {feature}
- data
  - models
    - {feature} eg auth
      ++ "user_model.dart"
  - repositories (implement)
    - {feature}
      ++ "user_repository.dart"
  - sources
    - {feature}
      - remote ++ "{feature}_remote_source.dart"
      - local ++ "{feature}_local_source.dart"
- domain
  - entities
  - repositories (abstract)
  - usecases

## Project assets structure

assets/fonts/
assets/images/
assets/images/png
assets/images/svg
assets/icons/
assets/icons/png
assets/icons/svg

# Git-branching

- main
- release
- hotfix
- bugfix
- dev
- feature-{feature_name}-{sub_module}

## Git Commit Message Structure (Conventional Commits)

template:
{type}(optional scope): {description}
[optional body]
[optional footer(s)]

### commit-type

add "!" after the type to draw attention to breaking change
eg: feat(auth)!: auto login when open app

- feat: add a new feature
- update: update a feature
- fix: fixes a bug
- refactor: that rewrite/restructure your code, do not change any behavior, that neither fixes a bug nor adds a feature.
- style: do not affect the meaning (white space, formatting, missing semi-colons, ui, etc)
- chore: Miscellaneous commits, changes that do not relate to a fix or feature
- docs: updates to documentation such as a the README or other markdown files
- test: Commits, that add missing tests or correct existing tests
- build: changes that affect the build system or external dependencies
- revert: reverts a previous commit
