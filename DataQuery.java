import java.util;
import java.util.function;

 public classDataQuery<Flight>{
    private Map<String , Comparator<Flight>> sorters;

    private Map<String , Predicate<Flight>> filters;


    public DataQuery() { 
        sorters = new LinkedHashMap<>();
        filters = new LinkedHashMap<>();
    }  
 

 public void setFilter(String filterName, Predicate<Flight> filter){
    filters.put(filterName, filter);
 }

 public void removeFilter(String filterName) {
    filters.remove(filterName);
  }

 public void clearFilters() {
    filters.clear();
  }

 public void setSort(String sortName, Comparator<Flight>comparator){
    sorters.put(sortName, comparator);
    }

public void removeSort(String sortName){
    sorters.remove(sortName);
 }

public Comparator<Flights> getFullComparator() { 
    return soters.values().stream()
    .reduce(Comparator:: thenComparing)
    .orElse((a,b) -> 0); 
 }

public Collection<Predicate<Flight>> getFilters() {
    return filters.values();
 } 

}