import java.util.List;
import java.util.function.Predicate;

public class QueryEngine {
    private DataService dataService;

    public QueryEngine(DataService dataService) {
        this.dataService = dataService;
    }

    public List<Flight> execute(DataQuery query, int offset, int limit) {
        List<Flight> flights = dataService.getAll();

        if (query.getFilters() != null) {
            for (Predicate<Flight> filter : query.getFilters()) {
                flights = flights.stream().filter(filter).toList();
            }
        }

        if (query.getFullComparator() != null) {
            flights = flights.stream().sorted(query.getFullComparator()).toList();
        }
        if (offset < 0)
            offset = 0;
        if (limit < 0)
            limit = 0;
        if (offset == 0 && limit == 0)
            return flights;

        return flights.stream().skip(offset).limit(limit).toList();
    }
}
