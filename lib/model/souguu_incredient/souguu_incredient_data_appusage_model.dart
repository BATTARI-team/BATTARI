import 'package:freezed_annotation/freezed_annotation.dart';

part 'souguu_incredient_data_appusage_model.g.dart';
part 'souguu_incredient_data_appusage_model.freezed.dart';

@freezed
class SouguuIncredientDataAppUsageModel with _$SouguuIncredientDataAppUsageModel {
  factory SouguuIncredientDataAppUsageModel({
    required String appName,
    required int useTime,
  }) = _SouguuIncredientDataAppUsageModel;

  factory SouguuIncredientDataAppUsageModel.fromJson(Map<String, dynamic> json) => _$SouguuIncredientDataAppUsageModelFromJson(json);
}
