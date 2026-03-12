import java.util.ArrayList;
import java.util.List;
public class DataService
{
    private List<Flight> flights;
    private Repository loader;
    
    public DataService(Repository loader)
    {
        this.loader = loader;
    }

    public int size()
    {
        return flights.size();
    }

    public List<Flight> getAll()
    {
        List<Flight> newFlights = new ArrayList<Flight>(flights);
        return newFlights;
    }
}
