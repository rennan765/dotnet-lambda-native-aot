using Amazon.Lambda.SQSEvents;
using System.Text.Json.Serialization;

namespace MaintainUserData.Infrastructure.Serializers;

[ExcludeFromCodeCoverage]
[JsonSerializable(typeof(SQSEvent))]
public partial class MaintainUserDataSerializer : JsonSerializerContext
{
}