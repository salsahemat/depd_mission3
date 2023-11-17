part of 'models.dart';

class Province extends Equatable {
	final String? provinceId;
	final String? province;

	const Province({this.provinceId, this.province});

	factory Province.fromMap(Map<String, dynamic> data) => Province(
				provinceId: data['province_id'] as String?,
				province: data['province'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'province_id': provinceId,
				'province': province,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Province].
	factory Province.fromJson(String data) {
		return Province.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Province] to a JSON string.
	String toJson() => json.encode(toMap());

	@override
	bool get stringify => true;

	@override
	List<Object?> get props => [provinceId, province];
}
