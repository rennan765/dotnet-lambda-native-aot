using MaintainUserData.Domain.Entities;
using MaintainUserData.Domain.ValueObjects;
using System.Text.Json.Serialization;

namespace MaintainUserData.Infrastructure.Serializers;

[ExcludeFromCodeCoverage]
[JsonSourceGenerationOptions(WriteIndented = true, GenerationMode = JsonSourceGenerationMode.Serialization, PropertyNamingPolicy = JsonKnownNamingPolicy.SnakeCaseLower)]
[JsonSerializable(typeof(User), GenerationMode = JsonSourceGenerationMode.Metadata)]
[JsonSerializable(typeof(ContactData), GenerationMode = JsonSourceGenerationMode.Metadata)]
[JsonSerializable(typeof(int))]
[JsonSerializable(typeof(string))]
[JsonSerializable(typeof(DateOnly))]
[JsonSerializable(typeof(DateTime))]
[JsonSerializable(typeof(DateTime?))]
[JsonSerializable(typeof(bool))]
public partial class UserSerializer : JsonSerializerContext
{
}