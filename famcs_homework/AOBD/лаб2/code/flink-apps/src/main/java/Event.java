import com.fasterxml.jackson.annotation.JsonProperty;

// одно событие из kafka.
// передавать такие объекты между узлами кластера
public class Event {
    @JsonProperty("user_id")
    public String userId;

    @JsonProperty("event_type")
    public String eventType;

    @JsonProperty("event_time")
    public long eventTime;   // когда событие произошло (мс)

    @JsonProperty("produce_ts")
    public long produceTs;   // когда producer его отправил (мс)

    public Event() {}
}
