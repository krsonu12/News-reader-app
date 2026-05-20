import 'package:auto_route/auto_route.dart';
import 'package:news_reader_app/core/routes/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, path: '/splash', initial: true),
    AutoRoute(page: HomeRoute.page, path: '/home'),
    AutoRoute(page: SearchRoute.page, path: '/search'),
    AutoRoute(page: ArticleDetailRoute.page, path: '/article_detail'),
    AutoRoute(page: BookmarksRoute.page, path: '/bookmark'),
  ];
}
