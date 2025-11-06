#!/usr/bin/env julia

# Example usage of Swirl.jl
# This script demonstrates how to use the Swirl package

println("="^60)
println("Swirl.jl Example Usage")
println("="^60)
println()

# First, we need to add the package to the current environment
using Pkg

# Add the local package (adjust path as needed)
println("Loading Swirl.jl...")
Pkg.activate(".")
Pkg.develop(path=@__DIR__)

using Swirl

println("✓ Swirl.jl loaded successfully!")
println()

# Example 1: List available courses
println("Example 1: Listing available courses")
println("-"^60)
Swirl.list_courses()

# Example 2: Check available functions
println("\nExample 2: Available Swirl functions")
println("-"^60)
println("  swirl()           - Start an interactive lesson")
println("  list_courses()    - List all available courses")
println("  delete_progress() - Reset all progress")
println("  install_course()  - Install a custom course (coming soon)")
println()

# Example 3: Understanding the course structure
println("\nExample 3: Exploring the Julia Basics course")
println("-"^60)
course = Swirl.create_basic_julia_course()
println("Course: $(course.name)")
println("Description: $(course.description)")
println("\nLessons:")
for (i, lesson) in enumerate(course.lessons)
    println("  $i. $(lesson.name)")
    println("     $(lesson.description)")
    println("     Questions: $(length(lesson.questions))")
end
println()

# Instructions for interactive use
println("="^60)
println("To start learning interactively, run:")
println("  julia> using Swirl")
println("  julia> swirl()")
println("="^60)
println()

# Note about testing
println("To run tests:")
println("  julia> using Pkg")
println("  julia> Pkg.test(\"Swirl\")")
println()
