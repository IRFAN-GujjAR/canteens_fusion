// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocoding_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _GeocodingApiService implements GeocodingApiService {
  _GeocodingApiService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://maps.googleapis.com/maps/api/geocode';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<GeocodingLatLongToAddressApiModel> convertLatLongToAddress({
    required String latLong,
    required String apiKey,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'latlng': latLong,
      r'key': apiKey,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
      _setStreamType<GeocodingLatLongToAddressApiModel>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(
              _dio.options,
              '/json',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
      ),
    );
    final value = GeocodingLatLongToAddressApiModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
