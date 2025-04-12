part of 'secret_crush_bloc.dart';

sealed class SecretCrushEvent extends Equatable {
  const SecretCrushEvent();

  @override
  List<Object> get props => [];
}

class FetchSecretCrush extends SecretCrushEvent {
  const FetchSecretCrush();
}
