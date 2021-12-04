/// Supported services used to make and process a request
enum OSRMService {
  /// Use Nominatim to reverse geocode a coordinate to an address
  coordToAddress,

  /// Use Nominatim to geocode an address to a coordinate
  addressToCoord,

  /// Find the nearest 'real' location (on a building or way/line) from a coordinate
  nearest,

  /// Plot the fastest route between waypoints
  route,
}
