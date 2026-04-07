using System.ComponentModel.DataAnnotations;

namespace HabitTracker.Models
{
    public enum KanbanStatus { Create = 0, Doing = 1, End = 2 }

    public class KanbanTask
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Title is required.")]
        [MaxLength(200)]
        public string Title { get; set; } = string.Empty;

        [MaxLength(1000)]
        public string Description { get; set; } = string.Empty;

        public KanbanStatus Status { get; set; } = KanbanStatus.Create;

        public string UserId { get; set; } = string.Empty;

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}
