import java.util.List;
import java.util.function.Predicate;

/*
    Implemented by: Serhii-Roman Kikot
    Query engine for filtering, sorting, and paginating flight data
*/
public class QueryEngine {
    private DataService dataService;

    // Initializes engine with data service source
    public QueryEngine(DataService dataService) {
        this.dataService = dataService;
    }

    // Executes query with filters, sorting, offset, and limit
    public List<Flight> execute(DataQuery query, int offset, int limit) {
        List<Flight> flights = dataService.getAll();

        // Apply all filters sequentially
        if (query.getFilters() != null) {
            for (Predicate<Flight> filter : query.getFilters()) {
                flights = flights.stream().filter(filter).toList();
            }
        }

        // Apply final comparator if provided
        if (query.getFullComparator() != null) {
            flights = flights.stream().sorted(query.getFullComparator()).toList();
        }

        if (offset < 0)
            offset = 0;
        if (limit < 0)
            limit = 0;

        // Return full result if pagination is disabled
        if (offset == 0 && limit == 0)
            return flights;

        // Return paginated result
        return flights.stream().skip(offset).limit(limit).toList();
    }
}
