using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using HabitTracker.Models;

namespace HabitTracker.Data
{
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options) { }

        public DbSet<Habit> Habits { get; set; }
        public DbSet<HabitLog> HabitLogs { get; set; }
        public DbSet<KanbanTask> KanbanTasks { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);

            const int KeyLen = 127;

            builder.Entity<ApplicationUser>(e =>
            {
                e.Property(u => u.Id).HasMaxLength(KeyLen);
                e.Property(u => u.UserName).HasMaxLength(191);
                e.Property(u => u.NormalizedUserName).HasMaxLength(191);
                e.Property(u => u.Email).HasMaxLength(191);
                e.Property(u => u.NormalizedEmail).HasMaxLength(191);
            });

            builder.Entity<IdentityRole>(e =>
            {
                e.Property(r => r.Id).HasMaxLength(KeyLen);
                e.Property(r => r.Name).HasMaxLength(191);
                e.Property(r => r.NormalizedName).HasMaxLength(191);
            });

            builder.Entity<IdentityUserRole<string>>(e =>
            {
                e.Property(ur => ur.UserId).HasMaxLength(KeyLen);
                e.Property(ur => ur.RoleId).HasMaxLength(KeyLen);
            });

            builder.Entity<IdentityUserClaim<string>>(e =>
                e.Property(uc => uc.UserId).HasMaxLength(KeyLen));

            builder.Entity<IdentityUserLogin<string>>(e =>
            {
                e.Property(ul => ul.UserId).HasMaxLength(KeyLen);
                e.Property(ul => ul.LoginProvider).HasMaxLength(KeyLen);
                e.Property(ul => ul.ProviderKey).HasMaxLength(KeyLen);
            });

            builder.Entity<IdentityUserToken<string>>(e =>
            {
                e.Property(ut => ut.UserId).HasMaxLength(KeyLen);
                e.Property(ut => ut.LoginProvider).HasMaxLength(KeyLen);
                e.Property(ut => ut.Name).HasMaxLength(KeyLen);
            });

            builder.Entity<IdentityRoleClaim<string>>(e =>
                e.Property(rc => rc.RoleId).HasMaxLength(KeyLen));
        }
    }
}
