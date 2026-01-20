using Microsoft.AspNetCore.Mvc;
using NetSeed.Application.DTOs;
using NetSeed.Infrastructure.Persistence;

namespace NetSeed.Api.Controllers;

[ApiController]
[Route("api/server")]
public class ServerController : ControllerBase
{
    [HttpPost("snapshot")]
    public IActionResult ReceiveSnapshot([FromBody] ServerSnapshotDto dto)
    {
        InMemoryStorage.Snapshots.Clear();
        InMemoryStorage.Snapshots.Add(dto);
        return Ok();
    }

    [HttpGet("players")]
    public IActionResult GetAllPlayers()
    {
        var players = InMemoryStorage.Snapshots
            .SelectMany(x => x.Players)
            .Distinct()
            .ToList();

        return Ok(players);
    }

    [HttpGet("players/count")]
    public IActionResult GetPlayersCount()
    {
        var total = InMemoryStorage.Snapshots
            .LastOrDefault()?.Player_Count ?? 0;

        return Ok(total);
    }
}