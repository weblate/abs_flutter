//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:abs_api/src/model/podcast_metadata.dart';
import 'package:abs_api/src/model/author_minified.dart';
import 'package:built_collection/built_collection.dart';
import 'package:abs_api/src/model/series_sequence.dart';
import 'package:abs_api/src/model/book_metadata.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'get_listening_stats200_response_items_value_media_metadata.g.dart';

/// GetListeningStats200ResponseItemsValueMediaMetadata
///
/// Properties:
/// * [title] - The title of the podcast.
/// * [subtitle] - The subtitle of the book. Will be null if there is no subtitle.
/// * [genres] - The genres of the podcast.
/// * [publishedYear] - The year the book was published. Will be null if unknown.
/// * [publishedDate] - The date the book was published. Will be null if unknown.
/// * [publisher] - The publisher of the book. Will be null if unknown.
/// * [description] - The description of the podcast.
/// * [isbn] - The ISBN of the book. Will be null if unknown.
/// * [asin] - The ASIN of the book. Will be null if unknown.
/// * [language] - The language of the podcast.
/// * [explicit] - Whether the podcast contains explicit content.
/// * [abridged] - Whether the book is abridged.
/// * [authors]
/// * [narrators]
/// * [series]
/// * [author] - The author of the podcast.
/// * [releaseDate] - The release date of the podcast.
/// * [feedUrl] - The URL of the podcast feed.
/// * [imageUrl] - The URL of the podcast's image.
/// * [itunesPageUrl] - The URL of the podcast's iTunes page.
/// * [itunesId] - The iTunes ID of the podcast.
/// * [itunesArtistId] - The iTunes artist ID of the podcast.
/// * [type] - The type of podcast (e.g., episodic, serial).
@BuiltValue()
abstract class GetListeningStats200ResponseItemsValueMediaMetadata
    implements
        Built<GetListeningStats200ResponseItemsValueMediaMetadata,
            GetListeningStats200ResponseItemsValueMediaMetadataBuilder> {
  /// One Of [BookMetadata], [PodcastMetadata]
  OneOf get oneOf;

  GetListeningStats200ResponseItemsValueMediaMetadata._();

  factory GetListeningStats200ResponseItemsValueMediaMetadata(
          [void updates(
              GetListeningStats200ResponseItemsValueMediaMetadataBuilder b)]) =
      _$GetListeningStats200ResponseItemsValueMediaMetadata;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(
          GetListeningStats200ResponseItemsValueMediaMetadataBuilder b) =>
      b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetListeningStats200ResponseItemsValueMediaMetadata>
      get serializer =>
          _$GetListeningStats200ResponseItemsValueMediaMetadataSerializer();
}

class _$GetListeningStats200ResponseItemsValueMediaMetadataSerializer
    implements
        PrimitiveSerializer<
            GetListeningStats200ResponseItemsValueMediaMetadata> {
  @override
  final Iterable<Type> types = const [
    GetListeningStats200ResponseItemsValueMediaMetadata,
    _$GetListeningStats200ResponseItemsValueMediaMetadata
  ];

  @override
  final String wireName =
      r'GetListeningStats200ResponseItemsValueMediaMetadata';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetListeningStats200ResponseItemsValueMediaMetadata object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    GetListeningStats200ResponseItemsValueMediaMetadata object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value,
        specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  GetListeningStats200ResponseItemsValueMediaMetadata deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetListeningStats200ResponseItemsValueMediaMetadataBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [
      FullType(BookMetadata),
      FullType(PodcastMetadata),
    ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc,
        specifiedType: targetType) as OneOf;
    return result.build();
  }
}
