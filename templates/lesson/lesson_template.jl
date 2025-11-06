# Lesson Template for Swirl.jl Course Creators

# This file provides a template for creating new lessons in Swirl.jl
# Copy this template and modify it to create your own lessons!

using Swirl

"""
Create a template lesson that can be used as a starting point.

Lesson Structure:
- Name: Short, descriptive name
- Description: What students will learn
- Questions: Array of Question objects

Question Types:
- :message      - Display information only (no answer required)
- :code         - Student writes Julia code, result is checked
- :multiple_choice - Student selects from options
- :exact        - Student types an exact string answer
"""
function create_template_lesson()
    lesson = Lesson(
        "Template Lesson Name",
        "A brief description of what this lesson teaches.",
        [
            # ============================================================
            # QUESTION 1: Introduction (Message)
            # ============================================================
            Question(
                "Welcome to this lesson! This first question is just a message " *
                "that introduces the topic. Students just press Enter to continue.\n\n" *
                "You can use \\n\\n to create paragraph breaks for readability.",
                :message,
                nothing,  # Messages don't need an answer
                ""        # No hint needed for messages
            ),
            
            # ============================================================
            # QUESTION 2: Simple Code Question
            # ============================================================
            Question(
                "Now let's try some code. Ask the student to perform a simple task.\n" *
                "For example: Calculate 10 + 5",
                :code,
                15,  # Expected result
                "Type: 10 + 5"  # Hint text
            ),
            
            # ============================================================
            # QUESTION 3: Code Question with Variables
            # ============================================================
            Question(
                "Variables created in previous questions persist!\n" *
                "If you asked them to create 'x = 10' earlier, you can now ask:\n" *
                "What is x * 2?",
                :code,
                20,  # Expected result (assuming x = 10)
                "Multiply x by 2"
            ),
            
            # ============================================================
            # QUESTION 4: Multiple Choice
            # ============================================================
            Question(
                "Multiple choice questions are great for concepts.\n\n" *
                "Which data structure would you use to store an ordered collection of items?",
                :multiple_choice,
                2,  # Index of correct answer (1-based)
                "Think about structures that maintain order",
                [
                    "Dictionary",
                    "Array",      # Correct answer
                    "Set",
                    "Tuple"
                ]
            ),
            
            # ============================================================
            # QUESTION 5: Exact String Answer
            # ============================================================
            Question(
                "For memorization or terminology, use exact answers.\n\n" *
                "What keyword is used to define a function in Julia?",
                :exact,
                "function",
                "It's the word you type before the function name"
            ),
            
            # ============================================================
            # QUESTION 6: More Complex Code
            # ============================================================
            Question(
                "You can ask students to write more complex code.\n" *
                "For example, defining a function:\n\n" *
                "Define a function called 'square' that takes one argument and returns its square.",
                :code,
                4,  # We'll test with square(2)
                "Use: square(x) = x^2 or square(x) = x * x, then call square(2)"
            ),
            
            # ============================================================
            # QUESTION 7: Closing Message
            # ============================================================
            Question(
                "Congratulations! You've completed this template lesson.\n\n" *
                "Key tips for creating good lessons:\n" *
                "- Start simple and build complexity gradually\n" *
                "- Provide clear, specific instructions\n" *
                "- Write helpful hints that guide without giving away answers\n" *
                "- Test all your code to ensure expected answers are correct\n" *
                "- Use messages to provide context and encouragement",
                :message,
                nothing
            )
        ]
    )
    
    return lesson
end

# ============================================================
# TIPS FOR CREATING EFFECTIVE LESSONS
# ============================================================

"""
Tips for Question Design:

1. CODE QUESTIONS:
   - Be specific about what to type
   - Test your expected answers!
   - Remember: variables persist between questions
   - You can build on previous questions
   
2. MULTIPLE CHOICE:
   - Use for conceptual understanding
   - Make distractors plausible but clearly wrong
   - Provide good hints that narrow down options
   
3. EXACT ANSWERS:
   - Use for terminology and specific values
   - Keep answers simple (case-sensitive matching)
   - Good for reinforcing vocabulary
   
4. MESSAGES:
   - Use to introduce new concepts
   - Provide context for upcoming questions
   - Celebrate progress and completion
   - Break up long sequences of questions
"""

# ============================================================
# EXAMPLE: Creating a Complete Lesson
# ============================================================

function create_example_lesson_loops()
    """
    This is a complete example lesson on loops in Julia.
    """
    lesson = Lesson(
        "Introduction to Loops",
        "Learn how to use for loops and while loops in Julia to repeat operations.",
        [
            Question(
                "Loops allow you to repeat operations multiple times. Julia has two main " *
                "types of loops: 'for' loops and 'while' loops.\n\n" *
                "Let's start with for loops, which iterate over a sequence.",
                :message,
                nothing
            ),
            
            Question(
                "The basic syntax of a for loop is:\n" *
                "for i in sequence\n    # code to repeat\nend\n\n" *
                "Try creating a for loop that prints numbers 1 through 5.\n" *
                "Use: for i in 1:5; println(i); end",
                :code,
                nothing,  # This will just execute, we're not checking output
                "Type: for i in 1:5; println(i); end"
            ),
            
            Question(
                "You can use loops to sum numbers. What is the sum of numbers from 1 to 10?\n" *
                "Hint: Create a variable 'total = 0', then use a for loop to add each number.",
                :code,
                55,
                "total = 0; for i in 1:10; total += i; end; total"
            ),
            
            Question(
                "While loops continue until a condition becomes false. The syntax is:\n" *
                "while condition\n    # code\nend\n\n" *
                "Create a variable 'count = 0', then use a while loop to increment it until it reaches 5.",
                :code,
                5,
                "count = 0; while count < 5; count += 1; end; count"
            ),
            
            Question(
                "Great! You've learned the basics of loops in Julia. Loops are essential " *
                "for processing collections and repeating operations efficiently.",
                :message,
                nothing
            )
        ]
    )
    
    return lesson
end

# ============================================================
# To test your lesson:
# ============================================================
# 1. Load your lesson function
# 2. Create a course with your lesson
# 3. Run it through Swirl

# Example:
# my_lesson = create_example_lesson_loops()
# test_course = Course("Test Course", "Testing my new lesson", [my_lesson])
# # Then modify courses.jl to include your course in get_available_courses()
