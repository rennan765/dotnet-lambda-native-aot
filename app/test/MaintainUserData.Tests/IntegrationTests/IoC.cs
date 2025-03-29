using MaintainUserData.Application.Gateways;
using MaintainUserData.Application.UseCases;
using MaintainUserData.Application.UseCases.Interfaces;
using MaintainUserData.Infrastructure.Gateways;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using MySqlConnector;
using System.Data;

namespace MaintainUserData.Tests.IntegrationTests;

public static class IoC
{
    static IoC()
    {
        ServiceCollection services = [];

        services
            .AddSingleton<IConfiguration>(new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("integrationtestsettings.json", optional: false, reloadOnChange: true)
                .Build());

        services
            .AddSingleton<IDbConnection>(sp =>
            {
                var connectionString = Environment
                    .GetEnvironmentVariable("CONNECTION_STRING");

                if (string.IsNullOrWhiteSpace(connectionString))
                {
                    var configuration = sp.GetRequiredService<IConfiguration>();

                    connectionString = configuration["ConnectionString"];
                }

                return new MySqlConnection(connectionString);
            })
            .AddSingleton<IUserGateway, UserGateway>()
            .AddSingleton<IMaintainUserDataUseCase, MaintainUserDataUseCase>();

        Provider = services.BuildServiceProvider();
    }

    public static ServiceProvider Provider { get; private set; }
}