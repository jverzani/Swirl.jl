module Swirl

using REPL
using Markdown
using Serialization

export swirl, install_course, uninstall_course, list_courses, delete_progress,
    reset_lesson_progress, reset_course_progress, list_progress, list_installed_courses

# Core types
include("types.jl")
include("progress.jl")
include("parser.jl")
include("runner.jl")
include("courses.jl")

"""
    swirl()

Start an interactive Swirl learning session. You'll be able to choose from
available courses and lessons to learn Julia interactively.
"""
function swirl()
    try
        while true  # Main loop to allow returning to menu
            println("\n" * "="^60)
            println("| Welcome to Swirl for Julia! 🌀")
            println("="^60)
            println()

            courses = get_available_courses()

            if isempty(courses)
                println("No courses installed yet!")
                println("The basic 'Julia Basics' course will be installed for you.")
                install_default_course()
                courses = get_available_courses()
            end

            # Course selection
            println("Available courses:")
            for (i, course) in enumerate(courses)
                println("  $i. $(course.name)")
            end
            println("  0. Exit Swirl")
            println()

            course_idx = get_user_choice("Select a course (enter number, or 0 to exit): ", 0:length(courses))

            if course_idx == 0
                println("\n👋 Thanks for using Swirl! Happy coding!")
                return
            end

            selected_course = courses[course_idx]

            # Lesson selection loop
            while true
                println("\nLessons in $(selected_course.name):")
                for (i, lesson) in enumerate(selected_course.lessons)
                    progress = get_lesson_progress(selected_course.name, lesson.name)
                    status = progress.completed ? "✓" : " "
                    println("  $i. [$status] $(lesson.name)")
                end
                println()
                println("Commands:")
                println("  0. Back to course selection")
                println("  reset <number>. Reset/retake a specific lesson (e.g., 'reset 1')")
                println("  reset all. Reset all lessons in this course")
                println()

                print("Select a lesson (enter number, command, or 0 to go back): ")
                input = strip(readline())

                # Check for reset commands
                if lowercase(input) == "reset all"
                    print("Are you sure you want to reset ALL lessons in this course? (yes/no): ")
                    confirm = lowercase(strip(readline()))
                    if confirm in ["yes", "y"]
                        reset_course_progress(selected_course.name)
                        println("✓ All lessons have been reset!")
                        sleep(1)
                    end
                    continue
                elseif startswith(lowercase(input), "reset ")
                    # Extract lesson number
                    try
                        lesson_num_str = strip(replace(lowercase(input), "reset" => ""))
                        lesson_num = parse(Int, lesson_num_str)
                        if lesson_num >= 1 && lesson_num <= length(selected_course.lessons)
                            lesson_name = selected_course.lessons[lesson_num].name
                            reset_lesson_progress(selected_course.name, lesson_name)
                            println("✓ Lesson '$(lesson_name)' has been reset!")
                            sleep(1)
                        else
                            println("Invalid lesson number. Please try again.")
                            sleep(1)
                        end
                    catch
                        println("Invalid command. Use 'reset <number>' (e.g., 'reset 2')")
                        sleep(1)
                    end
                    continue
                end

                # Check for exit command
                if lowercase(input) in ["exit", "quit", "bye"]
                    println("\n👋 Thanks for using Swirl! Happy coding!")
                    return
                end

                # Try to parse as lesson selection
                try
                    lesson_idx = parse(Int, input)

                    if lesson_idx == 0
                        break  # Go back to course selection
                    elseif lesson_idx >= 1 && lesson_idx <= length(selected_course.lessons)
                        selected_lesson = selected_course.lessons[lesson_idx]

                        # Run the lesson
                        run_lesson(selected_course.name, selected_lesson)

                        # After lesson completes or user exits, return to lesson menu
                        println("\nReturning to lesson selection...")
                        sleep(1)
                    else
                        println("Please enter a number between 0 and $(length(selected_course.lessons))")
                        sleep(1)
                    end
                catch
                    println("Invalid input. Please enter a number or command.")
                    sleep(1)
                end
            end
        end
    catch e
        if e isa InterruptException
            # User pressed Ctrl+C or typed 'exit' - return gracefully
            return
        else
            # Some other error - rethrow it
            rethrow(e)
        end
    end
end

function get_user_choice(prompt::String, range::AbstractRange)
    while true
        print(prompt)
        input = readline()

        # Allow 'exit' or 'quit' at any menu
        if lowercase(strip(input)) in ["exit", "quit", "bye"]
            println("\n👋 Thanks for using Swirl! Happy coding!")
            throw(InterruptException())  # Signal to exit Swirl, but not Julia
        end

        try
            choice = parse(Int, input)
            if choice in range
                return choice
            else
                println("Please enter a number between $(first(range)) and $(last(range))")
            end
        catch
            println("Invalid input. Please enter a number.")
        end
    end
end

# Install the default course on first run
function install_default_course()
    create_basic_julia_course()
    println("✓ Installed 'Julia Basics' course\n")
end

end # module