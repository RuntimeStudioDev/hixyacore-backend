namespace NetSeed.Application.DTOs;

public sealed class ServerSnapshotDto
{
    // {"server_id":"Minecraft-Server",
    // "players":["xDxvidz"],
    // "player_count":1,
    // "timestamp":1768875112610}
    
    public string Server_Id { get; set; } = default!;
    public List<string> Players { get; set; } = [];
    public int Player_Count { get; set; }
    public long Timestamp { get; set; }
}