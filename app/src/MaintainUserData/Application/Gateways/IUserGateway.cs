using MaintainUserData.Domain.Entities;

namespace MaintainUserData.Application.Gateways;

public interface IUserGateway
{
    Task<User> GetByDocumentAsync(string document);

    Task InsertAsync(User user);

    Task UpdateAsync(User user);
}