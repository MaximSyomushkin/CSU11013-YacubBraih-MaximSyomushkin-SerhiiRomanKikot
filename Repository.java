import java.util.List;

/*
    Implemented by: Serhii-Roman Kikot
    Defines a data source contract for loading flights
*/
interface Repository {
    // Loads and returns a list of flights
    public List<Flight> loadData();
}
