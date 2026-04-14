import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';

class RiverpodObserver extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    log("Provider $provider was initialized with $value");
  }

  @override
  void didDisposeProvider(
      ProviderBase<Object?> provider, ProviderContainer container) {
    log("Provider $provider was disposed");
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
      Object? previousValue,
      Object? newValue
  ) {print("Did upgrade provider: $provider")}
}
