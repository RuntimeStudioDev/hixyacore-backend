using NetSeed.Application.DTOs;

namespace NetSeed.Infrastructure.Persistence;

public static class InMemoryStorage
{
    public static List<ServerSnapshotDto> Snapshots { get; } = new();
}