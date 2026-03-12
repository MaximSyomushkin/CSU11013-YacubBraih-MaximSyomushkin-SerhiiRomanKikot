import java.util.ArrayList;
import java.util.List;

public class DataService {
    private List<Flight> flights;
    private Repository loader;
    private long lastLoadTime;
    private static final long CACHE_DURATION = (long) 5 * 60 * 1000;

    public DataService(Repository loader) {
        this.loader = loader;
        this.flights = loader.loadData();
        this.lastLoadTime = System.currentTimeMillis();
    }

    public int size() {
        return flights.size();
    }

    public List<Flight> getAll() {
        if (System.currentTimeMillis() - lastLoadTime > CACHE_DURATION) {
            this.flights = loader.loadData();
            this.lastLoadTime = System.currentTimeMillis();
        }
        
        if (flights == null)
            return new ArrayList<>();
        return new ArrayList<>(flights);
    }
}
