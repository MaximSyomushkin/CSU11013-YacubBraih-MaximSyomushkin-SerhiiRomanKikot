import java.util.ArrayList;
import java.util.List;

class RepositoryFile implements Repository {
  ArrayList<Flight> flights;
  RepositoryFile(ArrayList<Flight> flights) {
    this.flights = flights;
  }
  public List<Flight> loadData() {
    return this.flights;
    }
}

  
