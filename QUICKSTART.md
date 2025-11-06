# Swirl.jl Quick Start Guide

## Installation

### Option 1: From Git Repository
```julia
using Pkg
Pkg.add(url="https://github.com/yourusername/Swirl.jl")
```

### Option 2: Local Development
```julia
using Pkg
Pkg.develop(path="/path/to/Swirl.jl")
```

### Option 3: Manual Installation
1. Clone or download Swirl.jl
2. Start Julia in the Swirl.jl directory
3. Enter package mode by pressing `]`
4. Run: `activate .`
5. Run: `instantiate`
6. Press backspace to exit package mode
7. Run: `using Swirl`

## First Steps

Once installed, using Swirl is incredibly simple:

```julia
using Swirl

# Start learning!
swirl()
```

## What to Expect

When you run `swirl()`, you'll see:

1. **Course Selection Screen**
   ```
   ============================================================
   | Welcome to Swirl for Julia! 🌀
   ============================================================

   Available courses:
     1. Julia Basics

   Select a course (enter number):
   ```

2. **Lesson Selection Screen**
   ```
   Lessons in Julia Basics:
     1. [ ] Basic Math and Variables
     2. [ ] Types and Functions
     3. [ ] Vectors and Arrays

   Select a lesson (enter number):
   ```

3. **Interactive Questions**
   ```
   --- Question 1 of 7 ---

   Welcome to Swirl for Julia! Let's begin! Julia can be used 
   as a calculator. Try adding 5 + 3.

   >>> 5 + 3
   ✓ Correct!

   --- Question 2 of 7 ---
   ...
   ```

## Available Commands During Lessons

While working through a lesson, you can type:

- **Any Julia code** - Your answer to code questions
- **`hint`** or **`help`** - Get a hint for the current question
- **`skip`** - Skip the current question
- **`exit`**, **`quit`**, or **`bye`** - Save progress and exit

## Tips for Success

1. **Take Your Time**: There's no rush! Work at your own pace.

2. **Use Hints**: If you're stuck, type `hint` - that's what they're there for!

3. **Experiment**: Feel free to try different approaches. You get 3 attempts per question.

4. **Read Carefully**: The questions often contain important information or examples.

5. **Progress is Saved**: You can exit anytime and pick up where you left off.

## Example Session

Here's what a typical session looks like:

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

Welcome to Swirl for Julia! In this lesson, you'll learn the basics 
of Julia programming. We'll start with simple math operations and variables.

Let's begin! Julia can be used as a calculator. Try adding 5 + 3.

>>> 5 + 3
✓ Correct!

--- Question 2 of 7 ---

Great! Now try multiplication. What is 7 * 6?

>>> 7 * 6
✓ Correct!

--- Question 3 of 7 ---

Julia uses ^ for exponentiation. Calculate 2 raised to the power of 8.

>>> 2^8
✓ Correct!

--- Question 4 of 7 ---

Now let's learn about variables. In Julia, you assign values to 
variables using the = operator. Create a variable called 'x' and 
assign it the value 10.

>>> x = 10
✓ Correct!

--- Question 5 of 7 ---

Good! Variables let you store and reuse values. Now create a variable 
'y' with the value 5, then add x and y together.

>>> y = 5
✗ Not quite right.
Try again (attempt 2/3, or type 'hint' for help):
>>> hint
💡 Hint: First: y = 5, then: x + y (or just type: y = 5; x + y)
>>> y = 5; x + y
✓ Correct!

--- Question 6 of 7 ---

Excellent! Variables can be updated. Set x to be x * 2 (which should give 20).

>>> x = x * 2
✓ Correct!

--- Question 7 of 7 ---

Perfect! You've learned basic math operations and variables in Julia.

Press Enter to continue...

============================================================
| 🎉 Congratulations!
============================================================
You've completed Basic Math and Variables!
Score: 7/7
```

## Troubleshooting

### "No courses installed yet!"
This shouldn't happen - the Julia Basics course is automatically installed on first run.
If you see this, try reinstalling Swirl.jl.

### Progress not saving
Check that you have write permissions in your home directory. Progress is saved to:
`~/.swirl_julia/progress/`

### Error evaluating code
Make sure your Julia syntax is correct. Swirl runs your code in the Main module,
just like the regular REPL.

## What's Next?

After completing the Julia Basics course:

1. **Review**: Repeat lessons to reinforce learning
2. **Experiment**: Use what you learned in your own projects
3. **Contribute**: Create your own lessons! See CONTRIBUTING.md
4. **Share**: Tell others about Swirl.jl

## Other Useful Commands

```julia
# List all available courses and their descriptions
list_courses()

# Reset all progress (start fresh)
delete_progress()

# Get help on any function
?swirl
?list_courses
```

## Learning Path Recommendation

We recommend completing lessons in this order:

1. **Basic Math and Variables** - Foundation
2. **Types and Functions** - Core concepts
3. **Vectors and Arrays** - Data structures

Each lesson builds on previous ones, so following this order will give you
the smoothest learning experience.

---

**Ready to start?** Just type `swirl()` and begin your Julia journey! 🚀
