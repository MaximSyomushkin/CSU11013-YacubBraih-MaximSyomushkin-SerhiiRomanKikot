import java.util.*;
import java.util.function.*;

public class DataQuery {
    private Comparator<Flight> sorter;

    private Map<String, Predicate<Flight>> filters;

    public DataQuery() {
          sorter = (a, b) -> 0;
        filters = new LinkedHashMap<>();
    }

    public void setFilter(String filterName, Predicate<Flight> filter) {
        filters.put(filterName, filter);
    }

    public void removeFilter(String filterName) {
        filters.remove(filterName);
    }

    public void clearFilters() {
        filters.clear();
    }

    public void setSort(Comparator<Flight> comparator) {
        sorter = comparator;
    }

    public void removeSort() {
        sorter = (a, b) -> 0;
    }

    public Comparator<Flight> getFullComparator() {
        return sorter;
    }

    public Collection<Predicate<Flight>> getFilters() {
        return filters.values();
    }

}
