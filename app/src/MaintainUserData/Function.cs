using Amazon.Lambda.Core;
using Amazon.Lambda.RuntimeSupport;
using Amazon.Lambda.Serialization.SystemTextJson;
using Amazon.Lambda.SQSEvents;
using MaintainUserData.Application.UseCases.Interfaces;
using MaintainUserData.Infrastructure.Serializers;
using Microsoft.Extensions.DependencyInjection;

namespace MaintainUserData;

[ExcludeFromCodeCoverage]
public class Function
{
    private static IMaintainUserDataUseCase _useCase = null!;

    private static async Task Main()
    {
        Func<SQSEvent, ILambdaContext, Task> handler = HandleAsync;
        await LambdaBootstrapBuilder.Create(handler, new SourceGeneratorLambdaJsonSerializer<MaintainUserDataSerializer>())
            .Build()
            .RunAsync();
    }

    public static async Task HandleAsync(SQSEvent evnt, ILambdaContext context)
    {
        _useCase ??= IoC.Provider.GetRequiredService<IMaintainUserDataUseCase>();

        await _useCase
            .HandleAsync(evnt);
    }
}