class Flight
{
  String flightTime;
  String carrier;
  int carrierNum;
  String origin;
  String originCity;
  String originState;
  int originWAC;
  String destinationAir;
  String destinationCity;
  String destinationState;
  int destinationWAC;
  int crsDepartureTime;
  int departureTime;
  int crsArrivalTime;
  int arrivalTime;
  int cancelled;
  int diverted;
  int distance;

  Flight(String flightTime, String carrier, int carrierNum, String origin, String originCity, String originState, int originWAC, String destinationAir, String destinationCity, String destinationState, int destinationWAC, int crsDepartureTime, int departureTime, int crsArrivalTime, int arrivalTime, int cancelled, int diverted, int distance)
  {
    this.flightTime = flightTime;
    this.carrier = carrier;
    this.carrierNum = carrierNum;
    this.origin = origin;
    this.originCity = originCity;
    this.originState = originState;
    this.originWAC = originWAC;
    this.destinationAir = destinationAir;
    this.destinationCity = destinationCity;
    this.destinationState = destinationState;
    this.destinationWAC = destinationWAC;
    this.crsDepartureTime = crsDepartureTime;
    this.departureTime = departureTime;
    this.crsArrivalTime = crsArrivalTime;
    this.arrivalTime = arrivalTime;
    this.cancelled = cancelled;
    this.diverted = diverted;
    this.distance = distance;
  }
    public String toString() {
    return "Flight {" +
        "\n  Time: '" + flightTime + '\'' +
        ", Carrier: '" + carrier + "' (#" + carrierNum + ")" +
        "\n  Origin: " + origin + " (" + originCity + ", " + originState + ") [WAC: " + originWAC + "]" +
        "\n  Dest:   " + destinationAir + " (" + destinationCity + ", " + destinationState + ") [WAC: " + destinationWAC + "]" +
        "\n  Departure (CRS/Actual): " + crsDepartureTime + " / " + departureTime +
        "\n  Arrival   (CRS/Actual): " + crsArrivalTime + " / " + arrivalTime +
        "\n  Distance: " + distance + " miles" +
        "\n  Status: " + (cancelled == 1 ? "CANCELLED" : diverted == 1 ? "DIVERTED" : "OK") +
        "\n}";
  }

  }
}
