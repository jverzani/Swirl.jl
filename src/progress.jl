# Progress tracking functionality

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
    delete_progress()

Delete all saved progress. Returns to a fresh start.
"""
function delete_progress()
    progress_dir = get_progress_dir()
    if isdir(progress_dir)
        for file in readdir(progress_dir)
            rm(joinpath(progress_dir, file))
        end
        println("âœ“ All progress deleted")
    else
        println("No progress to delete")
    end
end
