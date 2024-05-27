# Use a supported .NET Core SDK version for the build stage
FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY . .
RUN dotnet restore "aspnet-core-dotnet-core.csproj"
RUN dotnet build "aspnet-core-dotnet-core.csproj" -c Release -o /app/build

# Use a runtime image for the runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS runtime
WORKDIR /app
COPY --from=build /app/build .
ENTRYPOINT ["dotnet", "aspnet-core-dotnet-core.dll"]
