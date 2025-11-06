# Swirl.jl Installation & Testing Guide

## Prerequisites

- Julia 1.6 or later (recommended: Julia 1.9+)
- Terminal/console access
- Write permissions in your home directory (for progress storage)

## Installation Methods

### Method 1: Direct from GitHub (Recommended when published)

```julia
using Pkg
Pkg.add(url="https://github.com/yourusername/Swirl.jl")
```

### Method 2: Local Development Installation

#### Step 1: Get the Package
```bash
# Clone or download the Swirl.jl directory to your machine
cd /path/to/your/projects
```

#### Step 2: Activate and Install
```julia
# Start Julia in the Swirl.jl directory
julia

# In Julia REPL:
using Pkg

# Activate the package environment
Pkg.activate(".")

# Install dependencies (all are stdlib, so this is quick)
Pkg.instantiate()

# Exit Julia
exit()
```

#### Step 3: Use the Package
```julia
# Start Julia again
julia

# Load Swirl
using Pkg
Pkg.activate("/path/to/Swirl.jl")
using Swirl

# Start learning!
swirl()
```

### Method 3: Add to Julia Depot (System-wide)

```julia
using Pkg
Pkg.develop(path="/path/to/Swirl.jl")

# Now you can use it from anywhere:
using Swirl
swirl()
```

### Method 4: Add to Project Environment

If you want Swirl available in a specific project:

```julia
# In your project directory
using Pkg
Pkg.activate(".")
Pkg.develop(path="/path/to/Swirl.jl")

# Now Swirl is available in this project
using Swirl
swirl()
```

## Verification

After installation, verify everything works:

```julia
using Swirl

# Should display welcome message and course list
swirl()

# Should list the Julia Basics course
list_courses()

# Check that functions are exported
@assert isdefined(Main, :swirl)
@assert isdefined(Main, :list_courses)
@assert isdefined(Main, :delete_progress)

println("✓ Swirl.jl installed successfully!")
```

## Running Tests

### Basic Test Run

```julia
using Pkg
Pkg.test("Swirl")
```

Expected output:
```
Test Summary:  | Pass  Total
Swirl.jl Tests |   XX     XX
```

### Detailed Testing

```julia
using Test
using Swirl

# Include the test file
include("test/runtests.jl")
```

### Manual Testing Checklist

Test each feature manually:

#### 1. Start Swirl
```julia
swirl()
# ✓ Should show welcome message
# ✓ Should list available courses
# ✓ Should accept numeric input
```

#### 2. Select Course and Lesson
```julia
# Select course 1, lesson 1
# ✓ Should show lesson title and description
# ✓ Should show first question
```

#### 3. Answer Questions
```julia
# Try: 5 + 3
# ✓ Should accept code input
# ✓ Should evaluate correctly
# ✓ Should show feedback (✓ Correct!)
```

#### 4. Use Special Commands
```julia
# Type: hint
# ✓ Should show hint text

# Type: skip
# ✓ Should skip to next question

# Type: exit
# ✓ Should save progress and exit
```

#### 5. Resume Progress
```julia
swirl()
# Select same lesson
# ✓ Should offer to restart or continue
# ✓ Progress should be remembered
```

#### 6. Complete Lesson
```julia
# Complete all questions
# ✓ Should show congratulations message
# ✓ Should show score
# ✓ Lesson should be marked complete
```

#### 7. Progress Management
```julia
delete_progress()
# ✓ Should delete all progress

list_courses()
# ✓ Should list available courses
```

## Troubleshooting

### Problem: "Package Swirl not found"

**Solution**: Make sure you've activated the package environment:
```julia
using Pkg
Pkg.activate("/path/to/Swirl.jl")
using Swirl
```

### Problem: "UndefVarError: swirl not defined"

**Solution**: The package didn't load correctly. Try:
```julia
# Force reload
using Pkg
Pkg.instantiate()  # Install dependencies
using Swirl
```

### Problem: Can't write progress files

**Error**: Permission denied when saving progress

**Solution**: Check home directory permissions:
```julia
# Check if directory is writable
mkpath(joinpath(homedir(), ".swirl_julia"))

# If that fails, check permissions:
# Linux/macOS:
run(`ls -la ~`)

# Windows: Check folder permissions in File Explorer
```

### Problem: Code evaluation errors

**Issue**: User code isn't evaluating correctly

**Debugging**:
```julia
# Test the evaluator directly
Swirl.safe_eval("2 + 2")
# Should return (success=true, result=4, error=nothing)

# Test with invalid code
Swirl.safe_eval("invalid syntax")
# Should return (success=false, result=nothing, error=...)
```

### Problem: Questions not loading

**Issue**: Lesson appears empty or errors

**Check**:
```julia
# Verify course structure
course = Swirl.create_basic_julia_course()
length(course.lessons)  # Should be 3
length(course.lessons[1].questions)  # Should be 7
```

### Problem: Julia version incompatibility

**Error**: Package requires Julia 1.6+

**Solution**: Update Julia:
- Download from https://julialang.org/downloads/
- Or use juliaup: `juliaup update`

### Problem: Tests failing

**Check**:
1. Julia version: `versioninfo()`
2. Package status: `using Pkg; Pkg.status()`
3. Run specific test:
   ```julia
   using Test
   using Swirl
   @test Swirl.safe_eval("2+2").result == 4
   ```

## Platform-Specific Notes

### Linux

```bash
# Install location
~/.julia/packages/Swirl/

# Progress location
~/.swirl_julia/progress/

# Should work out of the box
```

### macOS

```bash
# Same as Linux
~/.julia/packages/Swirl/
~/.swirl_julia/progress/

# May need to allow terminal access in System Preferences
```

### Windows

```powershell
# Install location
C:\Users\<username>\.julia\packages\Swirl\

# Progress location
C:\Users\<username>\.swirl_julia\progress\

# Use PowerShell or Windows Terminal (recommended)
# CMD also works but PowerShell is better
```

## Performance Considerations

Swirl.jl is lightweight and should run smoothly on:
- **RAM**: < 10 MB additional memory
- **CPU**: Minimal (evaluation happens on demand)
- **Disk**: < 1 MB for package, < 1 KB per lesson progress file

## Development Installation

For contributing to Swirl.jl:

```bash
# Clone the repository
git clone https://github.com/yourusername/Swirl.jl
cd Swirl.jl

# Start Julia with project
julia --project=.

# In Julia:
using Pkg
Pkg.instantiate()
Pkg.test()

# Make changes...

# Run tests after changes
Pkg.test()

# Or manual testing
using Swirl
swirl()
```

## Continuous Integration

For CI/CD pipelines:

```yaml
# .github/workflows/test.yml
name: Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: julia-actions/setup-julia@v1
        with:
          version: '1.9'
      - uses: julia-actions/julia-buildpkg@v1
      - uses: julia-actions/julia-runtest@v1
```

## Updating Swirl.jl

### If installed from GitHub:
```julia
using Pkg
Pkg.update("Swirl")
```

### If using local development:
```bash
cd /path/to/Swirl.jl
git pull origin main

# In Julia:
using Pkg
Pkg.instantiate()
```

## Uninstalling

### Complete removal:
```julia
using Pkg

# Remove package
Pkg.rm("Swirl")

# Remove progress (optional)
rm(joinpath(homedir(), ".swirl_julia"), recursive=true)
```

## Next Steps

After successful installation:

1. **Start Learning**: Run `swirl()`
2. **Read Documentation**: Check `README.md`
3. **Follow Quick Start**: See `QUICKSTART.md`
4. **Create Content**: Review `lessons/lesson_template.jl`
5. **Contribute**: Read `CONTRIBUTING.md`

## Getting Help

If you encounter issues:

1. **Check Documentation**: README, QUICKSTART, this guide
2. **Run Tests**: `Pkg.test("Swirl")` to diagnose
3. **Search Issues**: GitHub issues for similar problems
4. **Ask for Help**: Open a GitHub issue with:
   - Julia version (`versioninfo()`)
   - Error messages
   - Steps to reproduce
   - What you've already tried

## Success Indicators

You'll know installation was successful when:

✅ `using Swirl` loads without errors
✅ `swirl()` displays the welcome screen
✅ You can complete a question in a lesson
✅ Progress is saved and loaded correctly
✅ `Pkg.test("Swirl")` passes all tests

---

**Ready to Go?**

```julia
using Swirl
swirl()  # Begin your Julia journey!
```
