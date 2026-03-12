import java.util.List;
RepositoryFile repository;
DataService dataService;
DataQuery dataQuery;
QueryEngine queryEngine;
    
void setup() {
    repository = new RepositoryFile("flights2k.csv");
    dataService = new DataService(repository);
    queryEngine = new QueryEngine(dataService);
    dataQuery = new DataQuery();
    dataQuery.setFilter("byAirport", FlightFiltersFabric.byAirport("BDL"));
    dataQuery.setSort("byDate", FlightsSortersFabric.byDate(false));
    queryEngine.execute(dataQuery, 0,0).forEach(System.out::println);
    dataQuery.clearFilters();
    queryEngine.execute(dataQuery, 0, 10).forEach(System.out::println);
}
