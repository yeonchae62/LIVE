Feature: Filter Games

  Background:
    Given I have the following games:
      | title | platform | cost_value| genre         | subject1| dimensions | used_in_class | downloadable |
      | Game1 | Windows  | 5.00      | single-player | art     | 2D         | Y             | N            |
      | Game2 | Mac      | 15.0      | multi-player  | biology | 2D         | Y             | N            |
      | Game3 | Steam    | 21.00     | single-player | ecology |            | Y             | N            |
      | Game4 | Web      | 22.00     | multi-player  | medical | 3D         | N             | N            |
      | Game5 | PC       | 0.00      |               | nursing |            | N             | N            |
      | Game6 | IOS      | 0.00      |               | math    |            | N             | N            |
      | Game7 | HTML5    | 0.00      |               | language|            | N             | Y            |
      | Game8 | VR       | 0.00      |               | geography |          | N             | Y            |
    And I am on the game list page

  Scenario: Filter by price range from $0 to $10
    Given I am on the game list page
    When I select the price range "0to10"
    Then I should see the following games:
      | Game1  |

  Scenario: Filter by price range from $10 to $20
    When I select the price range "10to20"
    Then I should see the following games:
      | Game2  |

  Scenario: Filter by price above $20
    When I select the price range "above20"
    Then I should see the following games:
      | Game3  |
      | Game4  |

  Scenario: Filter by free price
    When I select the price range "free"
    Then I should see the following games:
      | Game5  |
      | Game6  |
      | Game7  |
      | Game8  |

  Scenario: Filter by platform: windows
    When I select the platform "windows"
    Then I should see the following games:
      | Game1|

  Scenario: Filter by platform: Mac
    When I select the platform "mac"
    Then I should see the following games:
      | Game2|

  Scenario: Filter by platform: steam
    When I select the platform "steam"
    Then I should see the following games:
      | Game3|

  Scenario: Filter by platform: web
    When I select the platform "web"
    Then I should see the following games:
      | Game4|

  Scenario: Filter by platform: PC
    When I select the platform "pc"
    Then I should see the following games:
      | Game5|

  Scenario: Filter by platform: Mobile
    When I select the platform "mobile"
    Then I should see the following games:
      | Game6|

  Scenario: Filter by platform: HTML5
    When I select the platform "html5"
    Then I should see the following games:
      | Game7|

  Scenario: Filter by platform: VR
    When I select the platform "vr"
    Then I should see the following games:
      | Game8|

  Scenario: Filter by subject: Art
    When I select the subject "art"
    Then I should see the following games:
      | Game1|

  Scenario: Filter by subject: biology
    When I select the subject "biology"
    Then I should see the following games:
      | Game2|

  Scenario: Filter by subject: ecology
    When I select the subject "ecology"
    Then I should see the following games:
      | Game3|

  Scenario: Filter by subject: Medical
    When I select the subject "medical"
    Then I should see the following games:
      | Game4|

  Scenario: Filter by subject: Nursing
    When I select the subject "nursing"
    Then I should see the following games:
      | Game5|

  Scenario: Filter by subject: Math
    When I select the subject "math"
    Then I should see the following games:
      | Game6|

  Scenario: Filter by subject: Language
    When I select the subject "language"
    Then I should see the following games:
      | Game7|

  Scenario: Filter by subject: Geography
    When I select the subject "geography"
    Then I should see the following games:
      | Game8|

  Scenario: Filter by genre: multi-player
    When I select the genre "multi"
    Then I should see the following games:
      | Game2 |
      | Game4 |

  Scenario: Filter by genre: single-player
    When I select the genre "single"
    Then I should see the following games:
      | Game1 |
      | Game3 |

  Scenario: Filter by dimensions: 2D
    When I select the dimension "2D"
    Then I should see the following games:
      | Game1  |
      | Game2  |

  Scenario: Filter by dimensions: 3D
    When I select the dimension "3D"
    Then I should see the following games:
      | Game4  |

  Scenario: Filter by other features (Used in Classroom)
    When I select the other feature "uic"
    Then I should see the following games:
      | Game1  |
      | Game2  |
      | Game3  |

  Scenario: Filter by other features (Downloadable)
    When I select the other feature "downloadable"
    Then I should see the following games:
      | Game7 |
      | Game8 |
