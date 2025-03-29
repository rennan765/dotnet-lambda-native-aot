using Amazon.Lambda.Core;
using Amazon.Lambda.Serialization.SystemTextJson;
using Dapper;

[assembly: LambdaSerializer(typeof(DefaultLambdaJsonSerializer))]
[module: DapperAot]