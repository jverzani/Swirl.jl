# Swirl.jl 🌀

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Learn Julia interactively in your console/terminal, inspired by the [swirl](https://swirlstats.com/) library for R!

## Overview

Swirl.jl is an interactive learning platform that teaches you Julia programming right in your REPL (Read-Eval-Print Loop). Work through lessons at your own pace, get instant feedback on your answers, and build your Julia skills step by step.

## Features

✨ **Interactive Learning**: Type real Julia code and get immediate feedback  
📚 **Structured Courses**: Progress through well-designed lessons  
💾 **Progress Tracking**: Your progress is automatically saved  
💡 **Hints & Help**: Get hints when you're stuck  
🎯 **Multiple Question Types**: Messages, multiple choice, code evaluation, and more  
🌟 **Built-in Content**: Comes with a comprehensive "Julia Basics" course

## Installation

```julia
# In Julia REPL
using Pkg
Pkg.add(url="https://github.com/yourusername/Swirl.jl")  # Update with actual URL when published
```

Or for local development:

```julia
using Pkg
Pkg.develop(path="/path/to/Swirl.jl")
```

## Quick Start

```julia
using Swirl

# Start learning!
swirl()
```

That's it! The interface will guide you through:
1. Selecting a course
2. Choosing a lesson
3. Working through interactive questions

## Usage

### Main Commands

```julia
# Start an interactive lesson
swirl()

# List all available courses
list_courses()

# Delete your saved progress (start fresh)
delete_progress()

# Install a custom course (coming soon)
install_course("Course Name", "path/to/course")

# Uninstall a course (coming soon)
uninstall_course("Course Name")
```

### During a Lesson

While working through a lesson, you can use these commands:
- **`hint`** or **`help`**: Get a hint for the current question
- **`skip`**: Skip the current question
- **`exit`**, **`quit`**, or **`bye`**: Exit the lesson (progress is saved)

### Example Session

```julia
julia> using Swirl

julia> swirl()

============================================================
| Welcome to Swirl for Julia! 🌀
============================================================

Available courses:
  1. Julia Basics

Select a course (enter number): 1

Lessons in Julia Basics:
  1. [ ] Basic Math and Variables
  2. [ ] Types and Functions
  3. [ ] Vectors and Arrays

Select a lesson (enter number): 1

============================================================
| Basic Math and Variables
============================================================
Learn basic arithmetic operations and how to assign variables in Julia.

--- Question 1 of 7 ---

Welcome to Swirl for Julia! Let's begin! Julia can be used as a 
calculator. Try adding 5 + 3.

>>> 5 + 3
✓ Correct!

--- Question 2 of 7 ---

Great! Now try multiplication. What is 7 * 6?

>>> 7 * 6
✓ Correct!

...
```

## Course Structure

Swirl.jl comes with the **Julia Basics** course, which includes:

1. **Basic Math and Variables**
   - Arithmetic operations (+, -, *, /, ^)
   - Variable assignment
   - Updating variables

2. **Types and Functions**
   - Understanding Julia's type system
   - Using `typeof()`
   - Built-in functions (sqrt, abs, etc.)
   - Defining your own functions

3. **Vectors and Arrays**
   - Creating arrays
   - Array indexing (1-based)
   - Array functions (length, sum, push!)
   - Using ranges

## How It Works

Swirl.jl evaluates your Julia code in real-time using the `Main` module, so:
- Variables you create persist between questions
- You can use any Julia feature or package
- Your code runs in the same environment as your REPL

Progress is automatically saved to `~/.swirl_julia/progress/`, so you can exit and resume anytime.

## Creating Custom Courses

(Documentation for creating custom courses coming soon!)

## FAQ

**Q: Where is my progress saved?**  
A: Progress is saved in `~/.swirl_julia/progress/` in your home directory.

**Q: Can I restart a completed lesson?**  
A: Yes! When you select a completed lesson, Swirl will ask if you want to restart it.

**Q: What if I make a mistake?**  
A: You get 3 attempts per question, and you can always type `hint` for help!

**Q: Can I use Swirl to learn advanced Julia topics?**  
A: Currently, Swirl.jl includes beginner content, but the system is designed to support courses on any Julia topic. Custom course creation will be supported in future versions.

## Contributing

Contributions are welcome! Whether it's:
- 🐛 Bug reports
- 💡 Feature suggestions
- 📚 New lesson content
- 🔧 Code improvements

Please feel free to open an issue or submit a pull request.

## Roadmap

- [ ] Support for custom course installation
- [ ] More built-in courses (intermediate/advanced topics)
- [ ] Course creation toolkit
- [ ] Better error messages and hints
- [ ] Support for multimedia content
- [ ] Achievements and badges
- [ ] Course sharing platform

## License

MIT License - see LICENSE file for details

## Acknowledgments

Inspired by the excellent [swirl](https://swirlstats.com/) package for R, which has helped countless people learn R programming.

## Author

Created with ❤️ for the Julia community

---

**Happy Learning! 🎉**

Start your Julia journey today with `swirl()`!
