import 'package:kiwi/kiwi.dart';
import 'package:routes/auth/bloc/auth_bloc.dart';
import 'package:routes/auth/bloc/login/login_bloc.dart';
import 'package:routes/auth/bloc/signup/signup_bloc.dart';
import 'package:routes/auth/data/auth_repo.dart';
import 'package:routes/routes_feed/bloc/feed_blocs.dart';
import 'package:routes/routes_feed/data/feed_repo.dart';
import 'package:routes/Constants.dart';

part 'app_injector.g.dart';

abstract class Injector {
  //Authentication
  @Register.singleton(AuthRepo, name: AUTH_REPO_IMPL, from: AuthRepoImpl)
  @Register.singleton(AuthBloc,
      resolvers: {AuthRepo: AUTH_REPO_IMPL}, from: AuthBloc, name: AUTH_BLOC)
  @Register.factory(LoginBloc,
      resolvers: {AuthBloc: AUTH_BLOC, AuthRepo: AUTH_REPO_IMPL},
      from: LoginBloc,
      name: LOGIN_BLOC)
  @Register.factory(SignUpBloc,
      resolvers: {AuthBloc: AUTH_BLOC, AuthRepo: AUTH_REPO_IMPL},
      from: SignUpBloc,
      name: SIGN_UP_BLOC)
  //Feed
  @Register.singleton(FeedRepo, name: MOCK_FEED_REPO, from: MockFeedRepo)
  @Register.factory(FeedBloc,
      resolvers: {FeedRepo: MOCK_FEED_REPO},
      from: MainFeedBloc,
      name: MAIN_FEED_BLOCK)
  void configure();
}

void inject() {
  var injector = _$Injector();
  injector.configure();
}
