// Openapi Generator last run: : 2024-08-04T15:50:17.850896
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    additionalProperties:
    DioProperties(pubName: 'abs_api', pubAuthor: 'Vito'),
    inputSpec: InputSpec(path: 'lib/openapi/openapi-spec.json'),
    generatorName: Generator.dio,
    reservedWordsMappings: {
        'update': 'update_',
    },
    inlineSchemaNameMappings: {
        'update': 'update_',
    },
    typeMappings: {
        'update': 'update_',
    },
    importMappings: {
        'update': 'update_',
    },
    runSourceGenOnOutput: true,
    outputDirectory: './api/abs_api',
)
class AbsApi {}