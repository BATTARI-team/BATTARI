import 'package:battari/model/souguu_incredient/souguu_incredient_data_appusage_model.dart';
import 'package:battari/model/souguu_incredient/souguu_incredient_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'souguu_app_incredient_model.g.dart';
part 'souguu_app_incredient_model.freezed.dart';

@freezed
class SouguuAppIncredientModel with _$SouguuAppIncredientModel {
  factory SouguuAppIncredientModel({
    required String type,
    required SouguuIncredientDataAppUsageModel appData,
  }) = _SouguuAppIncredientModel;

  factory SouguuAppIncredientModel.fromJson(Map<String, dynamic> json) =>
      _$SouguuAppIncredientModelFromJson(json);
}
