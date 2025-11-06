# Example Custom Course Template

# Define helper function for multiple choice questions (optional)
mc(q, choices, correct_idx, hint="") = Question(q, :multiple_choice, correct_idx, hint, choices)

# Create your course
my_course = Course(
    "My Custom Course",  # Course name
    "A brief description of what students will learn in this course.",  # Description
    [
        # Lesson 1
        Lesson(
            "Introduction to X",  # Lesson name
            "Learn the basics of X with hands-on examples.",  # Lesson description
            [
                # Question 1: Information message
                Question(
                    "Welcome to this lesson! Let's learn about X.",
                    :message,
                    nothing
                ),
                
                # Question 2: Code execution
                Question(
                    "Try adding 5 + 3",
                    :code,
                    8,  # Expected answer
                    "Type: 5 + 3"  # Hint
                ),
                
                # Question 3: Multiple choice
                mc(
                    "What is the capital of France?",
                    ["London", "Paris", "Berlin", "Madrid"],  # Choices
                    2,  # Correct answer (Paris is #2)
                    "It's known as the City of Light"  # Hint
                ),
                
                # Question 4: Code with variable creation
                Question(
                    "Create a variable x = 10",
                    :code,
                    10,
                    "Type: x = 10"
                ),
                
                # Question 5: Using the variable
                Question(
                    "Multiply x by 2",
                    :code,
                    20,
                    "Type: x * 2"
                ),
                
                # Question 6: Completion message
                Question(
                    "Great job! You've completed this lesson.",
                    :message,
                    nothing
                )
            ]
        ),
        
        # Lesson 2
        Lesson(
            "Advanced Topics",
            "Dive deeper into advanced concepts.",
            [
                Question(
                    "Let's explore more advanced topics...",
                    :message,
                    nothing
                ),
                
                # Add more questions here
                
                Question(
                    "Lesson complete!",
                    :message,
                    nothing
                )
            ]
        ),
        
        # Add more lessons as needed
    ]
)

# Return the course (this is required!)
my_course