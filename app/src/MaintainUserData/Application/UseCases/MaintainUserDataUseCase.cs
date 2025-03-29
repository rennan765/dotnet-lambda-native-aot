using Amazon.Lambda.SQSEvents;
using MaintainUserData.Application.Gateways;
using MaintainUserData.Application.UseCases.Interfaces;
using MaintainUserData.Domain.Entities;
using MaintainUserData.Infrastructure.Serializers;
using System.Text.Json;

namespace MaintainUserData.Application.UseCases;

public class MaintainUserDataUseCase(IUserGateway gateway) : IMaintainUserDataUseCase
{
    public virtual async Task HandleAsync(User user)
    {
        ArgumentNullException.ThrowIfNull(user);

        var fromDb = await gateway
            .GetByDocumentAsync(user.Document)
            .ConfigureAwait(false);

        if (fromDb is null)
        {
            await gateway
                .InsertAsync(user)
                .ConfigureAwait(false);

            return;
        }

        fromDb.Update(user);

        await gateway
            .UpdateAsync(fromDb)
            .ConfigureAwait(false);
    }

    public async Task HandleAsync(SQSEvent sqsEvent)
    {
        foreach (var record in sqsEvent.Records)
        {
            var user = JsonSerializer
                .Deserialize(record.Body, UserSerializer.Default.User)!;

            await HandleAsync(user)
                .ConfigureAwait(false);
        }
    }
}