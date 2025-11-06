# Swirl.jl File Structure

```
Swirl.jl/
│
├── Project.toml                 # Package manifest and dependencies
├── LICENSE                      # MIT License
│
├── README.md                    # Main documentation and overview
├── QUICKSTART.md               # Quick start guide for new users
├── CONTRIBUTING.md             # Guide for contributors
│
├── example.jl                  # Example usage script
│
├── src/                        # Source code
│   ├── Swirl.jl               # Main module file (entry point)
│   ├── types.jl               # Core data structures (Question, Lesson, Course)
│   ├── progress.jl            # Progress tracking and persistence
│   ├── parser.jl              # Code evaluation and answer checking
│   ├── runner.jl              # Interactive lesson execution
│   └── courses.jl             # Course management and built-in content
│
├── test/                       # Test suite
│   └── runtests.jl            # Unit tests
│
└── lessons/                    # Lesson templates and examples
    └── lesson_template.jl     # Template for creating new lessons
```

## File Descriptions

### Root Level

- **Project.toml**: Julia package manifest defining dependencies and metadata
- **LICENSE**: MIT license for the package
- **README.md**: Comprehensive documentation including features, installation, and usage
- **QUICKSTART.md**: Step-by-step guide for first-time users
- **CONTRIBUTING.md**: Guidelines for contributing code, lessons, or documentation
- **example.jl**: Demonstration script showing how to use the package

### Source Files (src/)

- **Swirl.jl**: Main module that exports public API and orchestrates the interactive learning experience
- **types.jl**: Defines core data structures:
  - `Question`: Individual questions with text, type, answer, and hints
  - `Lesson`: Collection of questions with metadata
  - `Course`: Collection of lessons
  - `LessonProgress`: Tracks user progress through lessons
  
- **progress.jl**: Handles saving and loading user progress:
  - Stores progress in `~/.swirl_julia/progress/`
  - Tracks current question, completion status, and scores
  - Provides functions to save, load, and delete progress
  
- **parser.jl**: Code evaluation and validation:
  - `safe_eval()`: Safely evaluates Julia code strings
  - `check_answer()`: Validates user responses against expected answers
  - Handles different question types (code, exact, multiple choice)
  
- **runner.jl**: Interactive lesson execution:
  - `run_lesson()`: Main lesson loop with user interaction
  - `run_question()`: Handles individual questions
  - Provides feedback, hints, and attempt tracking
  - Supports special commands (hint, skip, exit)
  
- **courses.jl**: Course management:
  - `get_available_courses()`: Lists all installed courses
  - `create_basic_julia_course()`: Built-in "Julia Basics" course
  - Course installation/uninstallation (planned)

### Tests (test/)

- **runtests.jl**: Comprehensive test suite covering:
  - Type creation and initialization
  - Code evaluation and error handling
  - Answer checking for all question types
  - Progress tracking
  - Course structure validation

### Lessons (lessons/)

- **lesson_template.jl**: Complete template and guide for creating custom lessons:
  - Example questions of each type
  - Best practices and tips
  - Complete working example lesson

## Module Architecture

```
Swirl Module
    ├── Types (Question, Lesson, Course, LessonProgress)
    ├── Progress Management (save/load/delete)
    ├── Parser (code evaluation, answer validation)
    ├── Runner (interactive lesson execution)
    └── Course Management (built-in courses, installation)
```

## Data Flow

1. **User starts**: Calls `swirl()`
2. **Course selection**: Lists available courses from `courses.jl`
3. **Lesson selection**: Shows lessons with progress status from `progress.jl`
4. **Lesson execution**: `runner.jl` iterates through questions
5. **Code evaluation**: User input processed by `parser.jl`
6. **Progress updates**: Saved by `progress.jl` after each question
7. **Completion**: Final statistics displayed, progress marked complete

## Storage Locations

- **User progress**: `~/.swirl_julia/progress/`
  - Format: `<course>_<lesson>.progress` (serialized Julia objects)
  
- **Courses** (future): `~/.swirl_julia/courses/`
  - Will store user-installed custom courses

## Public API

Main functions exported by the module:

```julia
swirl()              # Start interactive learning session
list_courses()       # List available courses
delete_progress()    # Reset all progress
install_course()     # Install custom course (planned)
uninstall_course()   # Remove course (planned)
```

## Dependencies

From Project.toml:
- **REPL**: For interactive console features
- **Markdown**: For formatted text display
- **Serialization**: For saving/loading progress

All dependencies are part of Julia standard library.

## Extension Points

The package is designed to be extensible:

1. **New question types**: Add to `Question` type and update `check_answer()`
2. **Custom courses**: Use `Lesson` and `Course` constructors
3. **New validation logic**: Extend `check_answer()` with custom validators
4. **Progress analytics**: Access `LessonProgress` data
5. **Alternative interfaces**: Use core types and functions programmatically

## Future Expansion

Planned directories/files:
- `src/importer.jl` - Import courses from external formats
- `src/exporter.jl` - Export courses to shareable formats  
- `lessons/advanced/` - Advanced topic lessons
- `docs/` - Generated documentation
- `assets/` - Images, diagrams for documentation
