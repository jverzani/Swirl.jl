# Swirl.jl vs R's swirl: Feature Comparison

## Overview

This document compares Swirl.jl with the original swirl package for R, highlighting similarities, differences, and design decisions.

## Core Similarities ✅

### Interactive REPL-Based Learning
- **Both**: Run entirely in the console/terminal
- **Both**: Users type real code and get immediate feedback
- **Both**: No web browser or GUI required

### Progress Tracking
- **Both**: Automatically save user progress
- **Both**: Allow users to resume where they left off
- **Both**: Track completion status for lessons

### Course Structure
- **Both**: Organize content into courses containing multiple lessons
- **Both**: Lessons consist of sequential questions
- **Both**: Support multiple question types

### Learning Philosophy
- **Both**: Learn by doing, not just reading
- **Both**: Provide hints and feedback
- **Both**: Allow multiple attempts per question
- **Both**: Encourage self-paced learning

## Key Differences 🔄

### 1. Implementation Language

**R swirl**:
- Written in R
- Uses R's evaluation system
- Integrates with R's package ecosystem

**Swirl.jl**:
- Written in Julia
- Uses Julia's Meta and Core evaluation
- Leverages Julia's type system and multiple dispatch

### 2. Question Types

**R swirl** supports:
- Text (info messages)
- Command (R code)
- Multiple choice
- Exact matching
- Figure (graphics)
- Video
- Script

**Swirl.jl** (v0.1) supports:
- Message (info)
- Code (Julia code)
- Multiple choice
- Exact matching

**Future Swirl.jl** could add:
- Figure support (Plots.jl integration)
- Video/media content
- Script-based questions

### 3. Course Distribution

**R swirl**:
- Install courses via `install_course_*()` functions
- Courses distributed as R packages
- GitHub integration for course installation
- swirl.swirlstats.org course network

**Swirl.jl** (v0.1):
- Built-in "Julia Basics" course
- Course installation planned for future versions
- Designed for easy extension

**Future**: Could implement similar course marketplace

### 4. Content Repository

**R swirl**:
- Large collection of community-created courses
- Multiple official courses (R Programming, Data Science, Statistics)
- Course creation tools (swirlify package)

**Swirl.jl**:
- Starting with one comprehensive basics course
- Template and documentation for course creation
- Community contribution encouraged

### 5. User Commands

**R swirl**:
```r
swirl()        # Start
bye()          # Exit
skip()         # Skip question
play()         # Experiment mode
nxt()          # Continue
info()         # Help
```

**Swirl.jl**:
```julia
swirl()        # Start
exit/quit/bye  # Exit
skip           # Skip question
hint/help      # Get hint
```

### 6. Technical Architecture

**R swirl**:
```
├── Content (YAML-based lessons)
├── Engine (R evaluation)
├── UI (Console interaction)
└── Analytics (optional)
```

**Swirl.jl**:
```
├── Content (Julia structs)
├── Engine (Meta/Core eval)
├── UI (REPL interaction)
└── Progress (Serialization)
```

## Feature Parity Checklist

| Feature | R swirl | Swirl.jl v0.1 | Notes |
|---------|---------|---------------|-------|
| Interactive lessons | ✅ | ✅ | Core feature |
| Progress tracking | ✅ | ✅ | Local storage |
| Multiple courses | ✅ | ⚠️ | One built-in, more coming |
| Course installation | ✅ | ⏳ | Planned |
| Multiple question types | ✅ | ⚠️ | Basic types implemented |
| Hints system | ✅ | ✅ | Per-question hints |
| Skip questions | ✅ | ✅ | Available |
| Play mode | ✅ | ⏳ | Could be added |
| Video content | ✅ | ⏳ | Future feature |
| Figure/plot questions | ✅ | ⏳ | Future feature |
| Analytics | ✅ | ❌ | Optional feature |
| Course creation tools | ✅ | ⚠️ | Template provided |
| Community courses | ✅ | ⏳ | Planned |

Legend: ✅ Implemented | ⚠️ Partial | ⏳ Planned | ❌ Not planned

## Design Decisions Explained

### Why Julia Structs Instead of YAML?

**R swirl** uses YAML files for lesson content:
```yaml
- Class: text
  Output: Welcome to the lesson!
  
- Class: cmd_question
  Output: What is 2 + 2?
  CorrectAnswer: 4
  Hint: Add 2 and 2
```

**Swirl.jl** uses Julia structs:
```julia
Question(
    "Welcome to the lesson!",
    :message,
    nothing
),
Question(
    "What is 2 + 2?",
    :code,
    4,
    "Add 2 and 2"
)
```

**Reasoning**:
1. **Type safety**: Julia's type system catches errors at parse time
2. **IDE support**: Autocomplete and syntax highlighting
3. **No parsing overhead**: Direct Julia objects
4. **Flexibility**: Easy to add custom validation functions
5. **Simplicity**: No external format to learn

**Trade-off**: Less separation between content and code, but more powerful

### Why Local Storage Only?

**R swirl** can optionally sync progress to cloud services.

**Swirl.jl** (v0.1) uses local storage only.

**Reasoning**:
1. **Privacy**: No data leaves user's machine
2. **Simplicity**: No authentication or networking complexity
3. **Reliability**: Works offline always
4. **Speed**: No network delays

**Future**: Could add optional cloud sync as plugin

### Why Fewer Question Types Initially?

**Swirl.jl** starts with core types and will expand.

**Reasoning**:
1. **MVP approach**: Get core functionality working first
2. **Extensibility**: Architecture supports easy addition
3. **Focus**: Perfect the basics before adding advanced features
4. **Community input**: Let users guide what to add next

## Advantages of Swirl.jl

### For Julia
1. **Native Julia**: Feels like part of the ecosystem
2. **Type system**: Leverage Julia's powerful types
3. **Performance**: Julia's speed for complex evaluations
4. **Unicode**: Full Unicode support for math symbols
5. **Multiple dispatch**: Natural for extending functionality

### For Learners
1. **Modern language**: Learn a contemporary, fast language
2. **Scientific computing**: Direct path to real-world applications
3. **Clean syntax**: Julia's elegant, mathematical notation
4. **Community**: Join the growing Julia ecosystem

### For Educators
1. **Easy to modify**: Pure Julia, no external formats
2. **Powerful**: Full Julia features in lessons
3. **Customizable**: Extend with custom validators
4. **Testable**: Easy to write tests for lessons

## Advantages of R swirl

### Maturity
1. **Established**: Years of development and refinement
2. **Content**: Large library of existing courses
3. **Community**: Active user and developer community
4. **Tools**: swirlify for course creation

### Features
1. **More question types**: Video, figure, script, etc.
2. **Course network**: Easy course distribution
3. **Analytics**: Optional progress tracking
4. **Polish**: Refined user experience

## Migration Path: R swirl → Swirl.jl

For R swirl course creators wanting to port content:

### Conceptual Mapping
```
R swirl                    →  Swirl.jl
-------------------------------------------
text questions             →  :message
cmd_question              →  :code
mult_question             →  :multiple_choice
text_question             →  :exact
figure questions          →  (future feature)
video questions           →  (future feature)
script questions          →  (future feature)
```

### Process
1. Identify question types in R swirl lesson
2. Map to Swirl.jl question types
3. Convert YAML to Julia Question structs
4. Test thoroughly in Swirl.jl
5. Adjust hints and feedback as needed

### Automation Potential
Could create a conversion tool:
```julia
convert_swirl_course("path/to/swirl/course")
# → Generates Swirl.jl lesson files
```

## Future Convergence

Both projects could benefit from:
1. **Shared lesson format**: Interoperable content
2. **Cross-language courses**: Learn both R and Julia
3. **Best practices**: Share pedagogical insights
4. **Tool ecosystem**: Course creation, testing, distribution

## Conclusion

**R swirl** is mature, feature-rich, and well-established.

**Swirl.jl** is new, focused, and growing.

Both serve the same noble goal: making programming accessible through interactive, hands-on learning in the console.

Swirl.jl brings this proven learning method to the Julia community, adapted to Julia's strengths and philosophy.

---

## Acknowledgment

Swirl.jl is deeply inspired by R's swirl package. We're grateful to the swirl team for pioneering console-based interactive learning and showing that this approach works beautifully for teaching programming.

## Related Links

- **R swirl**: https://swirlstats.com/
- **swirl GitHub**: https://github.com/swirldev/swirl
- **swirlify**: https://github.com/swirldev/swirlify
- **Julia**: https://julialang.org/
