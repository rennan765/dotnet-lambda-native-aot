using Amazon.Lambda.SQSEvents;
using MaintainUserData.Application.Gateways;
using MaintainUserData.Application.UseCases;
using MaintainUserData.Domain.Entities;
using MaintainUserData.Infrastructure.Serializers;
using System.Text.Json;

namespace MaintainUserData.Tests.UnitTests;

[Trait("MaintainUserDataUseCase", "Application")]
public class MaintainUserDataUseCaseTest
{
    [Fact(DisplayName = "Attempt to maintain a new user")]
    public async Task HandleAsync_User_New()
    {
        // arrange:
        AutoMocker mocker = new();

        User user = new()
        {
            Name = "Mike",
            BirthDate = DateOnly.FromDateTime(DateTime.Today.AddYears(-20)),
            Document = "00022211134",
            ContactData = new("+552197856987", "mike@gmail.com")
        };

        mocker.GetMock<IUserGateway>()
            .Setup(g => g.GetByDocumentAsync(user.Document))
            .ReturnsAsync((User)null!)
            .Verifiable();

        mocker.GetMock<IUserGateway>()
            .Setup(g => g.InsertAsync(It.Is<User>(u => u.Name == user.Name &&
                u.BirthDate == user.BirthDate &&
                u.Document == user.Document &&
                u.ContactData == user.ContactData)))
            .Verifiable();

        // act:
        var gateway = mocker.CreateInstance<MaintainUserDataUseCase>();
        await gateway.HandleAsync(user);

        // assert:
        mocker.Verify();
        mocker.Verify<IUserGateway>(g => g.UpdateAsync(It.IsAny<User>()), Times.Never);
    }

    [Fact(DisplayName = "Attempt to maintain an existing user")]
    public async Task HandleAsync_User_Existing()
    {
        // arrange:
        AutoMocker mocker = new();

        User user = new()
        {
            Name = "Mike Tyson",
            BirthDate = DateOnly.FromDateTime(DateTime.Today.AddYears(-20)),
            Document = "00022211134",
            ContactData = new("+552197856987", "mike_tyson@gmail.com")
        };

        User fromDb = new()
        {
            Id = 50,
            Name = "Mike",
            BirthDate = user.BirthDate,
            Document = user.Document,
            ContactData = new("+552197856987", "mike@gmail.com")
        };

        mocker.GetMock<IUserGateway>()
            .Setup(g => g.GetByDocumentAsync(user.Document))
            .ReturnsAsync(fromDb)
            .Verifiable();

        mocker.GetMock<IUserGateway>()
            .Setup(g => g.UpdateAsync(It.Is<User>(u => u.Id == fromDb.Id &&
                u.Name == user.Name &&
                u.BirthDate == user.BirthDate &&
                u.Document == user.Document &&
                u.ContactData == user.ContactData)))
            .Verifiable();

        // act:
        var gateway = mocker.CreateInstance<MaintainUserDataUseCase>();
        await gateway.HandleAsync(user);

        // assert:
        mocker.Verify();
        mocker.Verify<IUserGateway>(g => g.InsertAsync(It.IsAny<User>()), Times.Never);
    }

    [Fact(DisplayName = "Receiving SQS event")]
    public async Task HandleAsync_SQS()
    {
        // arrange:
        AutoMocker mocker = new();
        Mock<MaintainUserDataUseCase> useCaseMock = new(mocker.Get<IUserGateway>());

        var serializedUser = "{\"name\":\"Myke Tyson\", \"birth_date\":\"2000-05-10\", \"document\":\"00022211134\", \"contact_data\": {\"phone\": \"+552197856987\", \"email\": \"mike_tyson@gmail.com\"}}";

        var user = JsonSerializer
            .Deserialize(serializedUser, UserSerializer.Default.User)!;

        useCaseMock
            .Setup(uc => uc.HandleAsync(It.Is<User>(u => u.Name == user.Name &&
                u.Document == user.Document &&
                u.BirthDate == user.BirthDate &&
                u.ContactData == user.ContactData)))
            .Verifiable();

        // act:
        SQSEvent evnt = new()
        {
            Records = [new()
            {
                Body = serializedUser
            }]
        };

        await useCaseMock.Object.HandleAsync(evnt);

        // assert:
        useCaseMock.Verify();
    }
}