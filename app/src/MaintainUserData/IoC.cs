using MaintainUserData.Application.Gateways;
using MaintainUserData.Application.UseCases;
using MaintainUserData.Application.UseCases.Interfaces;
using MaintainUserData.Infrastructure.Gateways;
using Microsoft.Extensions.DependencyInjection;
using MySqlConnector;
using System.Data;

namespace MaintainUserData;

[ExcludeFromCodeCoverage]
public static class IoC
{
    static IoC()
    {
        ServiceCollection services = [];

        services
            .AddSingleton<IDbConnection>(_ => new MySqlConnection(Environment.GetEnvironmentVariable("CONNECTION_STRING")!))
            .AddSingleton<IUserGateway, UserGateway>()
            .AddSingleton<IMaintainUserDataUseCase, MaintainUserDataUseCase>();

        Provider = services.BuildServiceProvider();
    }

    public static ServiceProvider Provider { get; private set; }
}