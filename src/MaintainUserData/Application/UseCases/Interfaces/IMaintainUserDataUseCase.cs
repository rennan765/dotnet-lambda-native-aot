using Amazon.Lambda.SQSEvents;
using MaintainUserData.Domain.Entities;

namespace MaintainUserData.Application.UseCases.Interfaces;

public interface IMaintainUserDataUseCase
{
    Task HandleAsync(User user);

    Task HandleAsync(SQSEvent sqsEvent);
}