# =========================
# BUILD STAGE
# =========================
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# 🔹 Archivos que afectan restore
COPY *.sln .
COPY Directory.Packages.props .
COPY NuGet.config .  # si existe
COPY Directory.Build.props . # si existe

# 🔹 Copiamos csproj
COPY src/NetSeed.Api/NetSeed.Api.csproj src/NetSeed.Api/
COPY src/NetSeed.Application/NetSeed.Application.csproj src/NetSeed.Application/
COPY src/NetSeed.Domain/NetSeed.Domain.csproj src/NetSeed.Domain/
COPY src/NetSeed.Infrastructure/NetSeed.Infrastructure.csproj src/NetSeed.Infrastructure/

# 🔹 Restore correcto
RUN dotnet restore src/NetSeed.Api/NetSeed.Api.csproj

# 🔹 Copiamos el resto del código
COPY src/ src/

# 🔹 Publish (sin restore)
RUN dotnet publish src/NetSeed.Api/NetSeed.Api.csproj \
    -c Release \
    -o /app/publish \
    --no-restore

# =========================
# RUNTIME STAGE
# =========================
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

COPY --from=build /app/publish .

EXPOSE 8080
ENTRYPOINT ["dotnet", "NetSeed.Api.dll"]
