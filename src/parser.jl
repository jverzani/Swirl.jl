# Improved code parsing and evaluation

"""
    safe_eval(code_str)

Safely evaluate a string of Julia code and return the result.
For multi-statement code (separated by ; or newlines), returns the last result.
"""
function safe_eval(code_str::String)
    try
        # Parse the code - this might be multiple statements
        expr = Meta.parse(code_str)

        # Evaluate in Main module so variables persist
        result = Core.eval(Main, expr)

        return (success=true, result=result, error=nothing)
    catch e
        return (success=false, result=nothing, error=e)
    end
end

"""
    safe_eval_multi(code_str)

Evaluate code that may contain multiple statements separated by semicolons or newlines.
Returns the result of the LAST statement (like Julia REPL behavior).
"""
function safe_eval_multi(code_str::String)
    try
        # Check if there are multiple statements
        # Split on semicolons and evaluate each
        statements = split(code_str, ';')

        local result = nothing
        for stmt in statements
            stmt_stripped = strip(stmt)
            if !isempty(stmt_stripped)
                expr = Meta.parse(stmt_stripped)
                result = Core.eval(Main, expr)
            end
        end

        return (success=true, result=result, error=nothing)
    catch e
        return (success=false, result=nothing, error=e)
    end
end

"""
    check_answer(user_answer, expected_answer, question_type)

Check if the user's answer matches the expected answer based on question type.
Evaluates user code and checks if the result matches what we expect.
"""
function check_answer(user_answer::String, expected_answer, question_type::Symbol)
    if question_type == :exact
        return strip(user_answer) == strip(string(expected_answer))
    elseif question_type == :multiple_choice
        try
            choice = parse(Int, strip(user_answer))
            return choice == expected_answer
        catch
            return false
        end
    elseif question_type == :code
        # Use multi-statement evaluator to handle cases like: v = [10, 20, 30]; v[1]
        eval_result = safe_eval_multi(user_answer)

        if !eval_result.success
            return (correct=false, message="Error: $(eval_result.error)", result=nothing, show_result=false)
        end

        # Check if result matches expected
        if eval_result.result == expected_answer
            return (correct=true, message="", result=eval_result.result, show_result=true)
            # Special case: if expected answer is a type, check if they got the right type
        elseif isa(expected_answer, Type) && typeof(eval_result.result) == Type && eval_result.result == expected_answer
            return (correct=true, message="", result=eval_result.result, show_result=true)
            # Check for approximate equality for floating point
        elseif isa(expected_answer, AbstractFloat) && isa(eval_result.result, AbstractFloat)
            if isapprox(eval_result.result, expected_answer, rtol=1e-6)
                return (correct=true, message="", result=eval_result.result, show_result=true)
            else
                return (correct=false,
                    message="Not quite. You got $(eval_result.result), but expected approximately $(expected_answer)",
                    result=eval_result.result,
                    show_result=true)
            end
            # Check if they just created a variable and need to access it
        elseif isa(eval_result.result, Vector) && isa(expected_answer, Number)
            # They might have just done the first step (creating the vector)
            # Give them a helpful hint
            return (correct=false,
                message="Good start! You've created the vector. Now access the element as described in the question.",
                result=eval_result.result,
                show_result=true)
        elseif typeof(eval_result.result) == typeof(expected_answer)
            # Right type but wrong value
            return (correct=false,
                message="Not quite. You got $(eval_result.result), but the expected answer is $(expected_answer)",
                result=eval_result.result,
                show_result=true)
        else
            # Different type - provide context-aware message
            result_type_str = typeof(eval_result.result)
            expected_type_str = typeof(expected_answer)

            msg = "Not quite. Your answer produced $(result_type_str)"

            # Add helpful context
            if isa(eval_result.result, Vector) && length(eval_result.result) > 0
                msg *= ". Did you mean to access a specific element?"
            end

            return (correct=false, message=msg, result=eval_result.result, show_result=true)
        end
    end

    return false
end

"""
    execute_code_silently(code)

Execute code without returning or displaying the result. Used for setup code.
"""
function execute_code_silently(code::String)
    try
        Core.eval(Main, Meta.parse(code))
        return true
    catch e
        println("Warning: Setup code failed: $e")
        return false
    end
end