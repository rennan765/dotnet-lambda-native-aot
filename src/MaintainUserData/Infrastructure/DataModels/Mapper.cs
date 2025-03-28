using MaintainUserData.Domain.Entities;

namespace MaintainUserData.Infrastructure.DataModels;

[ExcludeFromCodeCoverage]
public static class Mapper
{
    public static UserDto ToUserDto(this User user)
    {
        ArgumentNullException.ThrowIfNull(user);

        return new()
        {
            Birth_Date = user.BirthDate,
            Creation_Time = user.CreationTime,
            Document = user.Document,
            Email = user.ContactData.Email,
            Id = user.Id,
            Is_Deleted = user.IsDeleted,
            Last_Delete_Time = user.LastDeleteTime,
            Last_Update_Time = user.LastUpdateTime,
            Name = user.Name,
            Phone = user.ContactData.Phone
        };
    }

    public static User ToUser(this UserDto dto)
    {
        ArgumentNullException.ThrowIfNull(dto);

        return new()
        {
            BirthDate = dto.Birth_Date,
            ContactData = new(dto.Phone, dto.Email),
            CreationTime = dto.Creation_Time,
            Document = dto.Document,
            Id = dto.Id,
            IsDeleted = dto.Is_Deleted,
            LastDeleteTime = dto.Last_Delete_Time,
            LastUpdateTime = dto.Last_Update_Time,
            Name = dto.Name
        };
    }
}