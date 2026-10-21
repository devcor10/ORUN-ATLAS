namespace ATLAS.Data;

/// <summary>
/// Stub data contract for local SQLite and future Azure SQL sync.
/// All critical writes go to the append-only EventLog.
/// </summary>
public interface IAtlasDataStore
{
    // Roster
    Task<IReadOnlyList<Inmate>> GetRosterAsync(string unitId);
    Task UpsertInmateAsync(Inmate inmate);

    // Keep-separates
    Task<IReadOnlyList<KeepSeparate>> GetActiveKeepSeparatesAsync(string unitId);
    Task AddKeepSeparateAsync(string inmateIdA, string inmateIdB, string reason);

    // Observations
    Task RecordObservationTickAsync(string? inmateId, string deputyId, string? note);

    // Immutable log
    Task AppendEventAsync(string eventType, string jsonPayload, string deputyId);

    // Sync stub
    Task<int> GetUnsyncedEventCountAsync();
    Task MarkEventsSyncedAsync(IEnumerable<long> eventIds);
}

public record Inmate(string Id, string LastName, string FirstName, string? Bunk, string? Classification);
public record KeepSeparate(string InmateIdA, string InmateIdB, string? Reason);
