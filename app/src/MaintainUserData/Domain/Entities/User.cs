using MaintainUserData.Domain.ValueObjects;

namespace MaintainUserData.Domain.Entities;

[ExcludeFromCodeCoverage]
public class User
{
    public int Id { get; init; }

    public string Name { get; set; }

    public string Document { get; set; }

    public DateOnly BirthDate { get; set; }

    public ContactData ContactData { get; set; }

    public DateTime CreationTime { get; init; } = DateTime.UtcNow;

    public DateTime LastUpdateTime { get; set; } = DateTime.UtcNow;

    public bool IsDeleted { get; set; } = false;

    public DateTime? LastDeleteTime { get; set; } = null!;

    public void Update(User user)
    {
        ArgumentNullException.ThrowIfNull(user);
        Name = user.Name;
        Document = user.Document;
        BirthDate = user.BirthDate;
        ContactData = user.ContactData;
        LastUpdateTime = DateTime.UtcNow;
    }

    public void Delete()
    {
        IsDeleted = true;
        LastDeleteTime = DateTime.UtcNow;
    }

    public void Recreate()
    {
        IsDeleted = false;
        LastUpdateTime = DateTime.UtcNow;
    }
}