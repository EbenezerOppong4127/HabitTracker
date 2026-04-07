using System.ComponentModel.DataAnnotations;

namespace HabitTracker.Models
{
    public enum HabitFrequency { Daily, Weekly }

    public class Habit
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Name is required.")]
        [MaxLength(100, ErrorMessage = "Name cannot exceed 100 characters.")]
        public string Name { get; set; } = string.Empty;

        [MaxLength(500, ErrorMessage = "Description cannot exceed 500 characters.")]
        public string Description { get; set; } = string.Empty;

        public HabitFrequency Frequency { get; set; } = HabitFrequency.Daily;

        /// <summary>Kanban column this habit currently lives in.</summary>
        public KanbanStatus Status { get; set; } = KanbanStatus.Create;

        public string UserId { get; set; } = string.Empty;

        public ICollection<HabitLog> HabitLogs { get; set; } = new List<HabitLog>();
    }
}
