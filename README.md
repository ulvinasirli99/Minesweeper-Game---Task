# Minesweeper Game

A Flutter implementation of the classic Minesweeper game, built using Clean Architecture principles and Flutter's built-in state management solutions.

## Task Requirements Implementation

### Core Game Features ✅
- Fully playable Minesweeper game with configurable grid sizes (8x8, 12x12, 16x16)
- Randomized mine placement with proper adjacent mine calculation
- Reveal logic with flood fill for empty tiles
- Flagging functionality with long press
- Win/loss detection with game over message
- Timer and mine counter
- Three difficulty levels (Easy, Medium, Hard)
- Quick restart functionality when game is over

### Technical Requirements ✅
- Built using only Flutter's built-in widget system (no external UI libraries)
- No image assets used - pure Flutter widgets
- Clean Architecture implementation for maintainable and testable code
- Fully responsive layout that adapts to both portrait and landscape orientations
- Optimized for phones and tablets with dynamic sizing
- Performance-optimized UI with efficient state management
- Comprehensive test coverage

### Target Platform Support ✅
- iOS 14+
- Android 10+
- Optimized for both phone and tablet form factors

## Architecture

The project follows Clean Architecture principles with three main layers:

### 1. Domain Layer
- **Entities**: Core business objects (`Tile`, `GameBoard`)
- **Repositories**: Abstract definitions of data operations
- **Use Cases**: Application-specific business rules
  - `CreateGame`
  - `RevealTile`
  - `ToggleFlag`

### 2. Data Layer
- **Repository Implementations**: Concrete implementations of domain repositories
- **Game Logic**: Core game mechanics implementation

### 3. Presentation Layer
- **Controllers**: State management using `ValueNotifier`
- **Widgets**: Reusable UI components
- **Screens**: Main game interface

## State Management

The application uses Flutter's built-in state management solutions:
- `ValueNotifier` for reactive state management
- No external state management libraries
- Clean and efficient state updates

## Testing

The project includes comprehensive test coverage:

### Unit Tests
- Repository implementation tests
- Game logic tests
- State management tests

### Widget Tests
- Game board widget tests
- Screen integration tests
- User interaction tests

## Getting Started

1. Clone the repository
2. Ensure Flutter is installed and up to date
3. Run `flutter pub get` to install dependencies
4. Run `flutter test` to execute tests
5. Run `flutter run` to start the game

## Game Features

### Difficulty Levels
- **Easy**: 8x8 grid with 10 mines
- **Medium**: 12x12 grid with 30 mines
- **Hard**: 16x16 grid with 60 mines

### Controls
- **Tap**: Reveal a tile
- **Long Press**: Flag/unflag a tile
- **Difficulty Buttons**: Start a new game with selected difficulty
- **Restart Button**: Quick restart with same settings (appears when game is over)

### Game Elements
- Numbers indicate adjacent mines
- Red flag marks suspected mine locations
- Timer tracks game duration
- Mine counter shows remaining mines
- Game over message shows win/loss status
- Restart button in app bar for quick new game

## Responsive Design

The game features a fully responsive design that adapts to different screen sizes and orientations:

### Portrait Mode
- Vertically stacked layout with game info at top
- Game board automatically sized to screen width
- Difficulty selection buttons optimized for vertical space
- Proper spacing and padding for comfortable gameplay

### Landscape Mode
- Game info panel moved to the left side
- Game board centered and sized to available height
- Optimized button layout for horizontal space
- Maintains square aspect ratio for game tiles

### Tablet Support
- Dynamically adjusts UI elements for larger screens
- Maintains proper proportions for game board
- Optimized touch targets for tablet interaction
- Consistent experience across different iPad sizes

### Implementation Details
- Uses `LayoutBuilder` for dynamic sizing
- `SafeArea` ensures visibility with notches and system UI
- Responsive button sizes (40% width in landscape, 80% in portrait)
- Maintains game board's square aspect ratio
- Prevents overflow issues during rotation
- No scrolling required during active gameplay

## Code Structure

```
lib/
├── core/
│   └── error/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── data/
│   └── repositories/
└── presentation/
    ├── controllers/
    ├── screens/
    └── widgets/
```

## Performance Considerations

- Efficient board state updates
- Minimal rebuilds using `ValueNotifier`
- Optimized flood fill algorithm for revealing tiles
- Memory-efficient game state management

## Future Improvements

Potential enhancements that could be added:
- Custom grid size configuration
- High score tracking
- Different game modes
- Sound effects and haptic feedback
- Theme customization

## Development Decisions

1. **Clean Architecture**: Chosen for maintainability and testability
2. **ValueNotifier**: Used for efficient state management without external dependencies
3. **Widget-Based UI**: Pure Flutter implementation without external UI libraries
4. **Comprehensive Testing**: Ensures reliability and maintainability
