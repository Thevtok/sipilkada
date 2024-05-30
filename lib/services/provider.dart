import 'package:flutter_application_1/models/agama.dart';
import 'package:flutter_application_1/models/difabel.dart';
import 'package:flutter_application_1/models/pendidikan.dart';
import 'package:flutter_application_1/models/profesi.dart';
import 'package:flutter_application_1/models/wilayah.dart';
import 'package:flutter_application_1/services/profile.dart';
import 'package:flutter_application_1/services/wilayah.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// PROFILE
final profileProvider = Provider<ProfileService>((ref) => ProfileService());

final agamaProvider = FutureProvider<List<Religion>?>((ref) async {
  return ref.watch(profileProvider).getRegion();
});
final pendidikanProvider = FutureProvider<List<Pendidikan>?>((ref) async {
  return ref.watch(profileProvider).getPendidikan();
});
final profesiProvider = FutureProvider<List<Profesi>?>((ref) async {
  return ref.watch(profileProvider).getProfesi();
});
final difabelProvider = FutureProvider<List<DifabelList>?>((ref) async {
  return ref.watch(profileProvider).getDifabel();
});

//  final jenisKelaminProvider = StateProvider<String>((ref) => '');
//   final agamastrProvider = StateProvider<String>((ref) => '');
//    final difabelstrProvider = StateProvider<String>((ref) => '');
//   final profesistrProvider = StateProvider<String>((ref) => '');
//    final pendidikanstrProvider = StateProvider<String>((ref) => '');
//   final nikahProvider = StateProvider<String>((ref) => '');
//    final kategoriProvider = StateProvider<String>((ref) => '');

// WILAYAH
final wilayahProvider = Provider<WilayahService>((ref) => WilayahService());

final provProvider = FutureProvider<List<Provinsi>?>((ref) async {
  return ref.watch(wilayahProvider).getProvinsi();
});
final agamaProProvider = StateProvider<int?>((ref) => null);
final difabelProProvider = StateProvider<int?>((ref) => null);
final pendidikanProProvider = StateProvider<int?>((ref) => null);
final profesiProProvider = StateProvider<int?>((ref) => null);
final idProProvider = StateProvider<int?>((ref) => null);
final idKabProvider = StateProvider<int?>((ref) => null);
final idKecProvider = StateProvider<int?>((ref) => null);
final idKelProvider = StateProvider<int?>((ref) => null);

final kabProvider = FutureProvider<List<Kabupaten>?>((ref) async {
  final page = ref.watch(idProProvider);

  return ref.watch(wilayahProvider).getKabupaten(page??1);
});
final kecProvider = FutureProvider<List<Kecamatan>?>((ref) async {
  final page = ref.watch(idKabProvider);

  return ref.watch(wilayahProvider).getKecamatan(page??1);
});
final kelProvider = FutureProvider<List<Kelurahan>?>((ref) async {
  final page = ref.watch(idKecProvider);

  return ref.watch(wilayahProvider).getKelurahan(page??1);
});


// DPT


// final dptServiceProvider = Provider<DPTService>((ref) => DPTService());

// final konstituenListProvider = FutureProvider<List<Konstituen>?>((ref) async {
//   final page = ref.watch(pageProvider);
//   return ref.watch(dptServiceProvider).getDpt(page);
// });

// final pageProvider = StateProvider<int>((ref) => 1);

