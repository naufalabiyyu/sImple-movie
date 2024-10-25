import 'package:witt/witt.dart';

import '../../app_router.dart';
import 'home_page.dart';
import 'home_page_provider.dart';

class HomeRoute {
  static const homePath = "/";

  static List<AppPage> route() {
    return [
      AppPage(
        path: homePath,
        builder: (context, args) => const HomePage(),
        providerBuilder: (context, args) => [
          WProvider(create: (context) => HomePageProvider(context)),
        ],
      ),
    ];
  }
}
