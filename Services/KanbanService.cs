using HabitTracker.Data;
using HabitTracker.Models;
using Microsoft.EntityFrameworkCore;

namespace HabitTracker.Services
{
    public class KanbanService(ApplicationDbContext context)
    {
        public async Task<List<KanbanTask>> GetTasksAsync(string userId) =>
            await context.KanbanTasks
                .Where(t => t.UserId == userId)
                .OrderBy(t => t.CreatedAt)
                .ToListAsync();

        public async Task AddTaskAsync(KanbanTask task)
        {
            context.KanbanTasks.Add(task);
            await context.SaveChangesAsync();
        }

        public async Task MoveAsync(int id, KanbanStatus status, string userId)
        {
            var task = await context.KanbanTasks
                .FirstOrDefaultAsync(t => t.Id == id && t.UserId == userId);
            if (task is null) return;
            task.Status = status;
            await context.SaveChangesAsync();
        }

        public async Task UpdateAsync(KanbanTask updated, string userId)
        {
            var task = await context.KanbanTasks
                .FirstOrDefaultAsync(t => t.Id == updated.Id && t.UserId == userId);
            if (task is null) return;
            task.Title = updated.Title;
            task.Description = updated.Description;
            await context.SaveChangesAsync();
        }

        public async Task DeleteAsync(int id, string userId)
        {
            var task = await context.KanbanTasks
                .FirstOrDefaultAsync(t => t.Id == id && t.UserId == userId);
            if (task is null) return;
            context.KanbanTasks.Remove(task);
            await context.SaveChangesAsync();
        }
    }
}
