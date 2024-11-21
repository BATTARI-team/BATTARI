import 'package:freezed_annotation/freezed_annotation.dart';

part 'souguu_incredient_data_model.g.dart';
part 'souguu_incredient_data_model.freezed.dart';

@freezed
class SouguuIncredientDataModel with _$SouguuIncredientDataModel {
  factory SouguuIncredientDataModel({
    required String type,
  }) = _SouguuIncredientDataModel;

  factory SouguuIncredientDataModel.fromJson(Map<String, dynamic> json) => _$SouguuIncredientDataModelFromJson(json);
}
