# Implements question 5.
# This class contains the host record definitions for the server
class hosts {
  host { 'titan.csit.rmit.edu.au':
    ip           => '131.170.5.131',
    host_aliases => 'titan',
  }
  host { 'jupiter.csit.rmit.edu.au':
    ip           => '131.170.5.135',
    host_aliases => 'jupiter',
  }
  host { 'saturn.csit.rmit.edu.au':
    ip           => '131.170.5.132',
    host_aliases => 'saturn',
  }
}
