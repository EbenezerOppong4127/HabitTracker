using HabitTracker.Data;
using HabitTracker.Models;
using Microsoft.EntityFrameworkCore;

namespace HabitTracker.Services
{
    public class HabitService(ApplicationDbContext context)
    {
        public async Task<List<Habit>> GetHabitsAsync(string userId) =>
            await context.Habits
                .Where(h => h.UserId == userId)
                .OrderBy(h => h.Name)
                .ToListAsync();

        public async Task<Habit?> GetHabitAsync(int id, string userId) =>
            await context.Habits
                .FirstOrDefaultAsync(h => h.Id == id && h.UserId == userId);

        public async Task<Habit> AddHabitAsync(Habit habit)
        {
            context.Habits.Add(habit);
            await context.SaveChangesAsync();
            return habit;
        }

        public async Task<bool> UpdateHabitAsync(Habit habit, string userId)
        {
            var existing = await context.Habits
                .FirstOrDefaultAsync(h => h.Id == habit.Id && h.UserId == userId);
            if (existing is null) return false;

            existing.Name        = habit.Name;
            existing.Description = habit.Description;
            existing.Frequency   = habit.Frequency;
            existing.Status      = habit.Status;
            await context.SaveChangesAsync();
            return true;
        }

        /// <summary>Move a habit to a different Kanban column without touching other fields.</summary>
        public async Task<bool> UpdateStatusAsync(int id, KanbanStatus status, string userId)
        {
            var habit = await context.Habits
                .FirstOrDefaultAsync(h => h.Id == id && h.UserId == userId);
            if (habit is null) return false;

            habit.Status = status;
            await context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> DeleteHabitAsync(int id, string userId)
        {
            var habit = await context.Habits
                .FirstOrDefaultAsync(h => h.Id == id && h.UserId == userId);
            if (habit is null) return false;

            context.Habits.Remove(habit);
            await context.SaveChangesAsync();
            return true;
        }
    }
}
