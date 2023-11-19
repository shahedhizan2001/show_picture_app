// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../feature/photo/application/facade.dart' as _i6;
import '../../feature/photo/domain/repo/repo.dart' as _i4;
import '../../feature/photo/infrastructure/remote/remote.dart' as _i3;
import '../../feature/photo/infrastructure/repo_impl/repo.dart' as _i5;
import '../../feature/photo/presentation/bloc/photos_bloc.dart' as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.PhotoRemote>(() => _i3.PhotoRemote());
    gh.factory<_i4.IPhotosRepo>(
        () => _i5.RepoImpl(remote: gh<_i3.PhotoRemote>()));
    gh.factory<_i6.PhotosFacade>(
        () => _i6.PhotosFacade(repo: gh<_i4.IPhotosRepo>()));
    gh.factory<_i7.PhotosBloc>(() => _i7.PhotosBloc(gh<_i6.PhotosFacade>()));
    return this;
  }
}
