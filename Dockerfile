# =========================
# BUILD STAGE
# =========================
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copiamos TODO el código primero
COPY src/ src/

# Restore
RUN dotnet restore src/NetSeed.Api/NetSeed.Api.csproj

# Publish
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
