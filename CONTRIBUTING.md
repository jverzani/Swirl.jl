# Contributing to Swirl.jl

Thank you for your interest in contributing to Swirl.jl! We welcome contributions from everyone.

## Ways to Contribute

### 🐛 Report Bugs
Found a bug? Please open an issue with:
- A clear, descriptive title
- Steps to reproduce the problem
- Expected vs actual behavior
- Your Julia version and OS

### 💡 Suggest Features
Have an idea? Open an issue describing:
- The feature and why it would be useful
- Any examples or use cases
- Potential implementation ideas (optional)

### 📚 Create Content
One of the best ways to contribute is creating new lessons and courses!

#### Creating a New Lesson

A lesson consists of a series of questions. Here's a template:

```julia
lesson = Swirl.Lesson(
    "Lesson Name",
    "Brief description of what students will learn",
    [
        # Message question (just displays information)
        Question(
            "Welcome message or explanation",
            :message,
            nothing
        ),
        
        # Code question (user writes Julia code)
        Question(
            "Instruction for what to do",
            :code,
            expected_result,  # What the code should produce
            "Hint text if they need help"
        ),
        
        # Multiple choice question
        Question(
            "Question text",
            :multiple_choice,
            2,  # Index of correct answer (1-based)
            "Hint text",
            ["Option 1", "Option 2", "Option 3"]  # Choices
        ),
        
        # Exact answer question (string matching)
        Question(
            "Question text",
            :exact,
            "expected answer",
            "Hint text"
        )
    ]
)
```

#### Best Practices for Lessons

1. **Start Simple**: Begin with easy concepts and build up
2. **Clear Instructions**: Be specific about what users should do
3. **Good Hints**: Hints should guide without giving away the answer
4. **Test Your Code**: Make sure all expected answers work correctly
5. **Provide Context**: Explain why something is useful or important
6. **Use Examples**: Show examples before asking users to try

### 🔧 Code Contributions

#### Setting Up Development Environment

```bash
git clone https://github.com/yourusername/Swirl.jl.git
cd Swirl.jl
julia --project=. -e 'using Pkg; Pkg.instantiate()'
```

#### Running Tests

```julia
using Pkg
Pkg.test("Swirl")
```

#### Code Style

- Follow [Julia style guidelines](https://docs.julialang.org/en/v1/manual/style-guide/)
- Use 4 spaces for indentation
- Add docstrings to public functions
- Keep functions focused and reasonably sized
- Add tests for new functionality

#### Pull Request Process

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Add tests if applicable
5. Ensure tests pass
6. Commit with clear messages (`git commit -m 'Add amazing feature'`)
7. Push to your fork (`git push origin feature/amazing-feature`)
8. Open a Pull Request

### 📖 Documentation

Help improve documentation by:
- Fixing typos or unclear explanations
- Adding examples
- Improving docstrings
- Creating tutorials or guides

## Project Structure

```
Swirl.jl/
├── src/
│   ├── Swirl.jl       # Main module file
│   ├── types.jl       # Data structures
│   ├── progress.jl    # Progress tracking
│   ├── parser.jl      # Code evaluation
│   ├── runner.jl      # Lesson execution
│   ├── courses.jl     # Course management
│   └── lesson.jl      # Lesson utilities (if needed)
├── test/
│   └── runtests.jl    # Test suite
├── lessons/           # Lesson content files
├── README.md          # Main documentation
└── Project.toml       # Package manifest
```

## Areas Needing Help

We especially welcome contributions in these areas:

- [ ] More lesson content (intermediate/advanced topics)
- [ ] Course import/export functionality
- [ ] Better error messages
- [ ] Improved hint system
- [ ] Progress visualization
- [ ] Windows compatibility testing
- [ ] Performance optimization
- [ ] Additional question types
- [ ] Lesson creation toolkit/DSL

## Questions?

Not sure about something? Feel free to:
- Open an issue with your question
- Start a discussion
- Reach out to maintainers

## Code of Conduct

Be respectful, inclusive, and constructive. We want Swirl.jl to be a welcoming project for everyone.

## Recognition

Contributors will be recognized in:
- The README
- Release notes
- Git commit history

Thank you for helping make learning Julia more accessible! 🎉
