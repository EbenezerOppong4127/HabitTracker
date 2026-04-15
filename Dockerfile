# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy csproj and restore dependencies
COPY ["HabitTracker.csproj", "./"]
RUN dotnet restore "HabitTracker.csproj"

# Copy the rest of the code and build
COPY . .
RUN dotnet publish "HabitTracker.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Use the ASP.NET runtime image for the final stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

# Copy the published output
COPY --from=build /app/publish .

# Command to run the app
ENTRYPOINT ["dotnet", "HabitTracker.dll"]
