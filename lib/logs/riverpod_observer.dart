// import 'dart:developer';
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/misc.dart';
//
// final class RiverpodObserver extends ProviderObserver {
//   @override
//   void didAddProvider(
//     ProviderBase<Object?> provider,
//     Object? value,
//     ProviderContainer container,
//   ) {
//     log("Provider $provider was initialized with $value");
//   }
//
//   @override
//   void didDisposeProvider(
//       ProviderBase<Object?> provider, ProviderContainer container) {
//     log("Provider $provider was disposed");
//   }
//
//   @override
//   void didUpdateProvider(
//       ProviderBase<Object?> provider, Object? previousValue, Object? newValue) {
//     log("Did upgrade provider: $provider x $previousValue x $newValue");
//   }
// }



import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class RiverpodObserver extends ProviderObserver {

  @override
  void didAddProvider(
      ProviderObserverContext context,
      Object? value,
      ) {
    log("Provider ${context.provider} initialized with $value");
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    log("Provider ${context.provider} was disposed");
  }

  @override
  void didUpdateProvider(
      ProviderObserverContext context,
      Object? previousValue,
      Object? newValue,
      ) {
    log(
      "Provider ${context.provider} updated: $previousValue -> $newValue",
    );
  }
}