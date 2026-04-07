using Microsoft.AspNetCore.Identity;

namespace HabitTracker.Models
{
    public class ApplicationUser : IdentityUser
    {
        public string DisplayName { get; set; } = string.Empty;
    }
}
