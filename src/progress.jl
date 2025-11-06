# Progress tracking functionality with reset capabilities

function get_progress_dir()
    dir = joinpath(homedir(), ".swirl_julia", "progress")
    mkpath(dir)
    return dir
end

function get_progress_file(course_name::String, lesson_name::String)
    safe_course = replace(course_name, r"[^a-zA-Z0-9_-]" => "_")
    safe_lesson = replace(lesson_name, r"[^a-zA-Z0-9_-]" => "_")
    return joinpath(get_progress_dir(), "$(safe_course)_$(safe_lesson).progress")
end

"""
    get_lesson_progress(course_name, lesson_name)

Retrieve progress for a specific lesson, or create new progress if none exists.
"""
function get_lesson_progress(course_name::String, lesson_name::String)
    progress_file = get_progress_file(course_name, lesson_name)

    if isfile(progress_file)
        try
            return deserialize(progress_file)
        catch
            # If deserialization fails, start fresh
        end
    end

    return LessonProgress(course_name, lesson_name)
end

"""
    save_lesson_progress(progress)

Save progress for a lesson.
"""
function save_lesson_progress(progress::LessonProgress)
    progress_file = get_progress_file(progress.course_name, progress.lesson_name)
    serialize(progress_file, progress)
end

"""
    reset_lesson_progress(course_name, lesson_name)

Reset progress for a specific lesson (unticks it and clears all progress).
"""
function reset_lesson_progress(course_name::String, lesson_name::String)
    progress_file = get_progress_file(course_name, lesson_name)
    if isfile(progress_file)
        rm(progress_file)
    end
end

"""
    reset_course_progress(course_name)

Reset progress for all lessons in a course.
"""
function reset_course_progress(course_name::String)
    progress_dir = get_progress_dir()
    safe_course = replace(course_name, r"[^a-zA-Z0-9_-]" => "_")

    # Find all progress files for this course
    for file in readdir(progress_dir)
        if startswith(file, safe_course * "_") && endswith(file, ".progress")
            rm(joinpath(progress_dir, file))
        end
    end
end

"""
    delete_progress()

Delete all saved progress. Returns to a fresh start.
"""
function delete_progress()
    progress_dir = get_progress_dir()
    if isdir(progress_dir)
        for file in readdir(progress_dir)
            rm(joinpath(progress_dir, file))
        end
        println("✓ All progress deleted")
    else
        println("No progress to delete")
    end
end

"""
    list_progress()

List all saved progress across all courses and lessons.
"""
function list_progress()
    progress_dir = get_progress_dir()

    if !isdir(progress_dir) || isempty(readdir(progress_dir))
        println("No saved progress found.")
        return
    end

    println("\n📊 Your Progress:")
    println("="^60)

    progress_files = filter(f -> endswith(f, ".progress"), readdir(progress_dir))

    # Group by course
    courses = Dict{String,Vector{LessonProgress}}()

    for file in progress_files
        try
            progress = deserialize(joinpath(progress_dir, file))
            if !haskey(courses, progress.course_name)
                courses[progress.course_name] = LessonProgress[]
            end
            push!(courses[progress.course_name], progress)
        catch
            # Skip corrupted files
        end
    end

    # Display progress by course
    for (course_name, lessons) in courses
        println("\n📚 $course_name")
        for lesson in lessons
            status = lesson.completed ? "✓" : "⏳"
            percentage = lesson.current_question > 0 ?
                         round(Int, 100 * lesson.correct_answers / lesson.current_question) : 0
            println("  [$status] $(lesson.lesson_name)")
            if !lesson.completed
                println("      Progress: Question $(lesson.current_question) | Score: $(lesson.correct_answers) correct")
            else
                println("      Completed! Score: $(lesson.correct_answers)")
            end
        end
    end
    println()
end