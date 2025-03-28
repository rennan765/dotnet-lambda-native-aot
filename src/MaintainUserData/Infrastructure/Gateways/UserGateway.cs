using Dapper;
using MaintainUserData.Application.Gateways;
using MaintainUserData.Domain.Entities;
using MaintainUserData.Infrastructure.DataModels;
using System.Data;

namespace MaintainUserData.Infrastructure.Gateways;

public class UserGateway(IDbConnection connection) : IUserGateway
{
    public const string GetUserByDocumentSql = @"
    SELECT *
    FROM tb_user
    WHERE document = @document;
    ";

    public const string InsertSql = @"
    INSERT INTO tb_user (name, document, birth_date, phone, email, creation_time, last_update_time, is_deleted, last_delete_time)
    VALUES (@name, @document, @birth_date, @phone, @email, @creation_time, @last_update_time, @is_deleted, @last_delete_time);
    ";

    public const string UpdateSql = @"
    UPDATE tb_user
    SET name = @name,
        document = @document,
        birth_date = @birth_date,
        phone = @phone,
        email = @email,
        creation_time = @creation_time,
        last_update_time = @last_update_time,
        is_deleted = @is_deleted,
        last_delete_time = @last_delete_time
    WHERE id = @id;
    ";

    private void Open()
    {
        if (connection!.State == ConnectionState.Broken)
        {
            connection.Close();
        }

        if (connection.State == ConnectionState.Closed)
        {
            connection.Open();
        }
    }

    public async Task<User> GetByDocumentAsync(string document)
    {
        Open();

        CommandDefinition command = new(GetUserByDocumentSql, new { document });

        var dto = await connection
            .QueryFirstOrDefaultAsync<UserDto>(command)
            .ConfigureAwait(false);

        return dto?.ToUser()!;
    }

    public async Task InsertAsync(User user)
    {
        ArgumentNullException.ThrowIfNull(user);
        Open();

        CommandDefinition command = new(InsertSql, user.ToUserDto());

        await connection
            .ExecuteAsync(command)
            .ConfigureAwait(false);
    }

    public async Task UpdateAsync(User user)
    {
        ArgumentNullException.ThrowIfNull(user);
        Open();

        CommandDefinition command = new(UpdateSql, user.ToUserDto());

        await connection
            .ExecuteAsync(command)
            .ConfigureAwait(false);
    }
}