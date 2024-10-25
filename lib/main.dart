import 'package:flutter/material.dart';
import 'package:watt/watt.dart';
import 'package:witt/witt.dart';

import 'app_router.dart';
import 'constants/configuration.dart';
import 'pages/home_page/home_route.dart';
import 'services/http_service.dart';
import 'services/movie_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final app = WMultiProvider(
    providers: [
      WProvider(create: (context) => HttpService()),
      WProvider(create: (context) => MovieService(context)),
    ],
    child: const _App(),
  );

  runApp(app);
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    final lightPalette = PaletteData.kLightPalette.copyWith(
      primary: ColorUtil.createMaterialColor(const Color(0xFF2D2F44)),
      onPrimary: ColorUtil.createMaterialColor(Colors.white),
      secondary: ColorUtil.createMaterialColor(const Color(0xFF50DBD4)),
      onSecondary: ColorUtil.createMaterialColor(Colors.white),
      tertiary: ColorUtil.createMaterialColor(const Color(0xFF0FDBC4)),
      background: ColorUtil.createMaterialColor(const Color(0xFFF3F5F8)),
    );

    return Watt(
      lightPalette: lightPalette,
      darkPalette: lightPalette,
      builder: (context, theme, darkTheme) {
        final palette = Palette.of(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: AppRouter.navigatorKey,
          theme: theme.copyWith(
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: palette.surface,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
            ),
          ),
          title: Configurations.appName,
          onGenerateRoute: (settings) => AppRouter.onGenerateRoute(
            settings: settings,
            pages: [
              ...HomeRoute.route(),
            ],
          ),
        );
      },
    );
  }
}
