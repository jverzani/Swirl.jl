# Core data structures for Swirl

"""
A question in a Swirl lesson. Can be multiple choice or require code evaluation.
"""
mutable struct Question
    text::String
    type::Symbol  # :message, :multiple_choice, :code, :exact
    answer::Any
    hint::String
    choices::Vector{String}  # For multiple choice
    validator::Union{Function,Nothing}  # Custom validation function
end

Question(text, type, answer, hint="") = Question(text, type, answer, hint, String[], nothing)

"""
A lesson containing a sequence of questions.
"""
struct Lesson
    name::String
    description::String
    questions::Vector{Question}
end

"""
A course containing multiple lessons.
"""
struct Course
    name::String
    description::String
    lessons::Vector{Lesson}
end

"""
Progress tracking for a specific lesson.
"""
mutable struct LessonProgress
    course_name::String
    lesson_name::String
    current_question::Int
    completed::Bool
    correct_answers::Int
    attempts::Int
end

LessonProgress(course::String, lesson::String) =
    LessonProgress(course, lesson, 1, false, 0, 0)

