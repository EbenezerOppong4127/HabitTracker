using HabitTracker.Data;
using HabitTracker.Models;
using Microsoft.EntityFrameworkCore;

namespace HabitTracker.Services
{
    public class HabitLogService(ApplicationDbContext context)
    {
        public async Task<bool> IsCompletedTodayAsync(int habitId) =>
            await context.HabitLogs
                .AnyAsync(l => l.HabitId == habitId
                            && l.Date.Date == DateTime.Today
                            && l.Completed);

        public async Task<Dictionary<int, bool>> GetTodayStatusAsync(string userId)
        {
            var today = DateTime.Today;
            var logs = await context.HabitLogs
                .Where(l => l.Habit.UserId == userId
                         && l.Date.Date == today
                         && l.Completed)
                .Select(l => l.HabitId)
                .ToListAsync();
            return logs.ToDictionary(id => id, _ => true);
        }

        public async Task ToggleCompletionAsync(int habitId, string userId)
        {
            // Verify ownership
            var habit = await context.Habits
                .FirstOrDefaultAsync(h => h.Id == habitId && h.UserId == userId);
            if (habit is null) return;

            var today = DateTime.Today;
            var existing = await context.HabitLogs
                .FirstOrDefaultAsync(l => l.HabitId == habitId && l.Date.Date == today);

            if (existing is null)
            {
                context.HabitLogs.Add(new HabitLog
                {
                    HabitId = habitId,
                    Date = DateTime.Today,
                    Completed = true
                });
            }
            else
            {
                existing.Completed = !existing.Completed;
            }

            await context.SaveChangesAsync();
        }
    }
}
