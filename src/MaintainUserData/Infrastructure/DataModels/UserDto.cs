namespace MaintainUserData.Infrastructure.DataModels;

[ExcludeFromCodeCoverage]
public record UserDto
{
    public int Id { get; init; }

    public string Name { get; init; }

    public string Document { get; init; }

    public DateOnly Birth_Date { get; init; }

    public string Phone { get; init; }

    public string Email { get; init; }

    public DateTime Creation_Time { get; init; }

    public DateTime Last_Update_Time { get; init; }

    public bool Is_Deleted { get; init; }

    public DateTime? Last_Delete_Time { get; init; }
}