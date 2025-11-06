# Improved Lesson runner - handles interactive lesson flow with natural interaction

"""
    run_lesson(course_name, lesson)

Run an interactive lesson, tracking progress and providing feedback.
"""
function run_lesson(course_name::String, lesson::Lesson)
    println("\n" * "="^60)
    println("| $(lesson.name)")
    println("="^60)
    println(lesson.description)
    println()
    println("💡 Available commands: 'hint' (get help), 'skip' (skip question),")
    println("   'back' (return to menu), 'info' (show commands again)")
    println()

    progress = get_lesson_progress(course_name, lesson.name)

    # Start from saved progress or beginning
    start_idx = progress.completed ? 1 : progress.current_question

    if progress.completed
        println("You've already completed this lesson!")
        print("Do you want to restart? (yes/no): ")
        response = lowercase(strip(readline()))
        if response != "yes" && response != "y"
            return
        end
        progress = LessonProgress(course_name, lesson.name)
        start_idx = 1
    end

    # Run through questions
    for (idx, question) in enumerate(lesson.questions[start_idx:end])
        actual_idx = start_idx + idx - 1

        if !run_question(question, actual_idx, length(lesson.questions))
            # User wants to exit
            progress.current_question = actual_idx
            save_lesson_progress(progress)
            println("\nProgress saved. Type swirl() to continue later!")
            return
        end

        progress.correct_answers += 1
        progress.current_question = actual_idx + 1
        save_lesson_progress(progress)
    end

    # Lesson completed!
    progress.completed = true
    save_lesson_progress(progress)

    println("\n" * "="^60)
    println("| 🎉 Congratulations!")
    println("="^60)
    println("You've completed $(lesson.name)!")
    println("Score: $(progress.correct_answers)/$(length(lesson.questions))")
    println()
end

"""
    run_question(question, idx, total)

Run a single question and return true if successful, false if user wants to exit.
"""
function run_question(question::Question, idx::Int, total::Int)
    println("\n--- Question $idx of $total ---")
    println()

    if question.type == :message
        # Just display information
        println(question.text)
        println()
        print("Press Enter to continue...")
        readline()
        return true
    end

    # Display the question
    println(question.text)
    println()

    # Display choices for multiple choice
    if question.type == :multiple_choice && !isempty(question.choices)
        for (i, choice) in enumerate(question.choices)
            println("  $i. $choice")
        end
        println()
    end

    # Get user answer with attempts
    max_attempts = 3
    attempts = 0

    while attempts < max_attempts
        attempts += 1

        if question.type == :code
            print("julia> ")
        else
            print("Your answer: ")
        end

        user_input = readline()

        # Check for special commands
        if lowercase(strip(user_input)) in ["exit", "quit", "bye"]
            return false
        elseif lowercase(strip(user_input)) in ["back", "menu", "main"]
            println("⊳ Returning to course menu...")
            return false
        elseif lowercase(strip(user_input)) in ["skip"]
            println("⊳ Skipping this question...")
            return true
        elseif lowercase(strip(user_input)) in ["hint", "help", "?"]
            if !isempty(question.hint)
                println("💡 Hint: $(question.hint)")
            else
                println("💡 No hint available for this question.")
            end
            attempts -= 1  # Don't count hint requests as attempts
            continue
        elseif lowercase(strip(user_input)) in ["info", "commands"]
            println("\n💡 Available commands:")
            println("   'hint' or '?' - Get a hint for this question")
            println("   'skip' - Skip this question and move to the next")
            println("   'back' - Return to the lesson selection menu")
            println("   'exit' - Save progress and quit Swirl")
            println()
            attempts -= 1  # Don't count info requests as attempts
            continue
        end

        # Check the answer
        result = check_answer(user_input, question.answer, question.type)

        if question.type == :code && result isa NamedTuple
            if result.correct
                # Show what their code evaluated to for transparency
                if result.show_result && result.result !== nothing
                    println(result.result)
                end
                println("✓ Correct!")
                println()
                return true
            else
                # Show the evaluation result
                if result.show_result && result.result !== nothing
                    println(result.result)
                end
                println("✗ $(result.message)")
                if attempts < max_attempts
                    println("Try again (attempt $(attempts+1)/$max_attempts, or type 'hint' for help):")
                end
            end
        elseif result == true || (result isa Bool && result)
            println("✓ Correct!")
            println()
            return true
        else
            println("✗ Not quite right.")
            if attempts < max_attempts
                println("Try again (attempt $(attempts+1)/$max_attempts, or type 'hint' for help):")
            end
        end
    end

    # Max attempts reached
    println("\n⊳ The correct answer was: $(question.answer)")
    if !isempty(question.hint)
        println("💡 $(question.hint)")
    end
    println()

    return true
end