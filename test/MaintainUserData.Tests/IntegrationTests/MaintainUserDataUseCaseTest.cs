using Dapper;
using FluentAssertions;
using MaintainUserData.Application.Gateways;
using MaintainUserData.Application.UseCases;
using MaintainUserData.Application.UseCases.Interfaces;
using MaintainUserData.Domain.Entities;
using MaintainUserData.Infrastructure.DataModels;
using MaintainUserData.Infrastructure.Gateways;
using MySqlConnector;

namespace MaintainUserData.Tests.IntegrationTests;

[Trait("MaintainUserDataUseCaseTest", "Integration")]
public class MaintainUserDataUseCaseTest
{
    private readonly MySqlConnection _connection;
    private readonly IUserGateway _gateway;
    private readonly IMaintainUserDataUseCase _useCase;

    public MaintainUserDataUseCaseTest()
    {
        _connection = new(Environment.GetEnvironmentVariable("CONNECTION_STRING")!);
        _gateway = new UserGateway(_connection);
        _useCase = new MaintainUserDataUseCase(_gateway);
    }

    private async Task DeleteFromDocumentAsync(string document)
    {
        CommandDefinition command = new(@"DELETE FROM tb_user WHERE document = @document", new { document });

        await _connection
            .ExecuteAsync(command)
            .ConfigureAwait(false);
    }

    private async Task<int> InsertAsync(User user)
    {
        await DeleteFromDocumentAsync(user.Document)
            .ConfigureAwait(false);

        CommandDefinition command = new(UserGateway.InsertSql, user.ToUserDto());

        await _connection
            .ExecuteAsync(command)
            .ConfigureAwait(false);

        return (await _gateway
            .GetByDocumentAsync(user.Document)
            .ConfigureAwait(false))
            .Id;
    }

    [Fact(DisplayName = "Inserting a new user")]
    public async Task Inserting_A_New_User()
    {
#if DEBUG
        // do not run on debug mode
        return;
#endif

        // arrange:
        User user = new()
        {
            Name = "Mike",
            BirthDate = DateOnly.FromDateTime(DateTime.Today.AddYears(-20)),
            Document = "00022211134",
            ContactData = new("+552197856987", "mike@gmail.com")
        };

        await DeleteFromDocumentAsync(user.Document);

        // act:
        await _useCase
            .HandleAsync(user);

        // assert:
        var fromDb = await _gateway.GetByDocumentAsync(user.Document);
        fromDb.Should().NotBeNull();
    }

    [Fact(DisplayName = "Updating an existing user")]
    public async Task Updating_An_Existing_User()
    {
#if DEBUG
        // do not run on debug mode
        return;
#endif

        // arrange:
        User user = new()
        {
            Name = "Mike",
            BirthDate = DateOnly.FromDateTime(DateTime.Today.AddYears(-20)),
            Document = "00022211134",
            ContactData = new("+552197856987", "mike@gmail.com")
        };

        var id = await InsertAsync(user);

        User newUser = new()
        {
            Name = "Mike Tyson",
            BirthDate = DateOnly.FromDateTime(DateTime.Today.AddYears(-20)),
            Document = "00022211134",
            ContactData = new("+552197856987", "mike_tyson@gmail.com")
        };

        // act:
        await _useCase
            .HandleAsync(newUser);

        // assert:
        var fromDb = await _gateway.GetByDocumentAsync(user.Document);
        fromDb.Should().NotBeNull();

        fromDb.Id.Should().Be(id);
        fromDb.Name.Should().Be(newUser.Name);
        fromDb.ContactData.Should().Be(newUser.ContactData);
    }
}