# Build stage
FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
WORKDIR /src
COPY . .
RUN dotnet restore "aspnet-core-dotnet-core.csproj"
RUN dotnet publish "aspnet-core-dotnet-core.csproj" -c Release -o /app/publish

# Runtime stage
FROM laptevss/dotnet-aspnet:2.2.8-stretch-slim AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "aspnet-core-dotnet-core.dll"]
