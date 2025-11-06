# courses_rprogramming.jl
# Julia port of swirl’s “R Programming” basics course
# Mirrors lesson ordering from swirl: Basic Building Blocks, Workspace & Files,
# Sequences of Numbers, Vectors, Missing Values, Subsetting Vectors,
# Matrices & Data Frames, Logic, Functions, (map/broadcast/comprehensions),
# Group operations (groupby), Looking at Data, Dates & Times.

# All questions use Swirl.Question / Lesson from types.jl and runner flow.

# Helper to present small multiple choice blocks
mc(q, choices, correct_idx, hint="") = Question(q, :multiple_choice, correct_idx, hint, choices)

function create_rprogramming_julia_course()
    lessons = Lesson[]

    # 1. Basic Building Blocks  (parity with swirl lesson 1)
    push!(lessons, Lesson(
        "Basic Building Blocks",
        "Use Julia as a calculator, learn assignment, and simple expressions.",
        [
            Question("Welcome! In Julia, try 5 + 7.", :code, 12, "Type: 5 + 7"),
            Question("Multiply 6 by 7.", :code, 42, "Type: 6 * 7"),
            Question("Exponentiation uses ^. Compute 2^5.", :code, 32, "Type: 2^5"),
            Question("Create a variable a = 10.", :code, 10, "Type: a = 10"),
            Question("Create b = 3 and compute a / b.", :code, 10 / 3, "Type: b = 3; a / b"),
            Question("Update a to a = a + 5.", :code, 15, "Type: a = a + 5"),
            Question("Great job! End of lesson.", :message, nothing)
        ]
    ))

    # 2. Workspace and Files (swirl lesson 2 → Julia REPL & filesystem)
    push!(lessons, Lesson(
        "Workspace and Files",
        "Inspect variables and interact with the filesystem from Julia.",
        [
            Question("List names in Main with names(Main). Is :a present? Create a=1 if needed, then check.", :code, true,
                "Try: a = 1; :a in names(Main)"),
            mc("Which function shows the current working directory?", ["ls()", "pwd()", "cd()", "readdir()"], 2,
                "REPL prompt often shows it; the function returns it."),
            Question("Print the current working directory.", :code, pwd(), "Type: pwd()"),
            Question("Create a directory named 'swirl_tmp' using mkpath.", :code, true,
                "Type: mkpath(\"swirl_tmp\"); isdir(\"swirl_tmp\")"),
            Question("List files in the current folder.", :code, Vector{String}, "Type: readdir()"),
            Question("Great! End of lesson.", :message, nothing)
        ]
    ))

    # 3. Sequences of Numbers
    push!(lessons, Lesson(
        "Sequences of Numbers",
        "Create integer ranges and dense vectors.",
        [
            Question("Create the range 1:10 and collect it to a Vector.", :code, collect(1:10), "Type: collect(1:10)"),
            Question("Create 0:2:10 and collect it.", :code, collect(0:2:10), "Type: collect(0:2:10)"),
            Question("Use range(start, length, step): make [3,6,9,12].", :code, [3, 6, 9, 12],
                "Type: collect(range(3, length=4, step=3))"),
            Question("Make 5 equally spaced numbers from 0 to 1.", :code, range(0, 1, length=5),
                "Type: range(0, 1, length=5)"),
            Question("Nice! End of lesson.", :message, nothing)
        ]
    ))

    # 4. Vectors
    push!(lessons, Lesson(
        "Vectors",
        "Construct, index, and mutate 1D arrays.",
        [
            Question("Create v = [10,20,30,40]. Return v[2].", :code, 20, "Type: v = [10,20,30,40]; v[2]"),
            Question("Change the last element to 99.", :code, [10, 20, 30, 99],
                "Type: v[end] = 99; v"),
            Question("Append 5 with push!.", :code, [10, 20, 30, 99, 5],
                "Type: push!(v, 5); v"),
            Question("Vector comprehension: squares = [x^2 for x in 1:5]. Return squares.", :code, [1, 4, 9, 16, 25],
                "Type exactly as shown."),
            Question("Done!", :message, nothing)
        ]
    ))

    # 5. Missing Values
    push!(lessons, Lesson(
        "Missing Values",
        "Work with missing and skip them in computations.",
        [
            Question("Create w = [1, missing, 3]. What is skipmissing(w) |> sum?", :code, 4,
                "Type: sum(skipmissing(w))"),
            mc("Which is the literal for a missing value in Julia?", ["NA", "None", "missing", "null"], 3),
            Question("Replace missings with 0 using coalesce.(w, 0).", :code, [1, 0, 3],
                "Type: coalesce.(w, 0)"),
            Question("Great!", :message, nothing)
        ]
    ))

    # 6. Subsetting Vectors
    push!(lessons, Lesson(
        "Subsetting Vectors",
        "Logical, integer, and set-based indexing.",
        [
            Question("Let v = collect(1:10). Return the even entries (use v .% 2 .== 0).", :code, [2, 4, 6, 8, 10],
                "Type: v = collect(1:10); v[v .% 2 .== 0]"),
            Question("Return elements at positions [1,3,5].", :code, [1, 3, 5],
                "Type: v[[1,3,5]]"),
            Question("Filter values in {3,7,9}.", :code, [3, 7, 9],
                "Type: v[in.(v, Ref([3,7,9]))]"),
            Question("Nice!", :message, nothing)
        ]
    ))

    # 7. Matrices and DataFrames
    push!(lessons, Lesson(
        "Matrices and DataFrames",
        "Reshape arrays; intro to DataFrames.jl style tables.",
        [
            Question("Make A = reshape(collect(1:6), 2, 3). Return size(A).", :code, (2, 3),
                "Type: A = reshape(collect(1:6), 2, 3); size(A)"),
            mc("Matrix indexing is:", ["0-based", "1-based"], 2),
            Question("Sum each column: sum(A, dims=1).", :code, [6 8 10],
                "Type: sum(A, dims=1)"),
            Question("(Optional) If DataFrames is loaded, construct DataFrame(a=1:3, b=4:6) and return nrow(df).",
                :code, 3, "using DataFrames; df = DataFrame(a=1:3, b=4:6); nrow(df)"),
            Question("Good!", :message, nothing)
        ]
    ))

    # 8. Logic
    push!(lessons, Lesson(
        "Logic",
        "Boolean operators and short-circuiting.",
        [
            mc("Which operator is elementwise AND?", ["&&", "||", ".&", ".&&"], 3,
                "Short-circuit ops are scalar; dot versions broadcast."),
            Question("Evaluate [true,false,true] .| [false,false,true].", :code, [true, false, true],
                "Use .| for elementwise OR"),
            Question("all(x .> 0) on x=[1,2,-1] returns…", :code, false,
                "Type: all([1,2,-1] .> 0)"),
            Question("Done.", :message, nothing)
        ]
    ))

    # 9. Functions
    push!(lessons, Lesson(
        "Functions",
        "Define functions, multiple dispatch, broadcasting.",
        [
            Question("Define double(x)=2x; evaluate double(7).", :code, 14, "double(x) = 2x; double(7)"),
            Question("Anonymous function: map(x->x^2, 1:4).", :code, [1, 4, 9, 16],
                "Type exactly"),
            Question("Broadcast: (1:4) .^ 2.", :code, [1, 4, 9, 16], "Type: collect((1:4) .^ 2)"),
            Question("End.", :message, nothing)
        ]
    ))

    # 10. Map / “apply” family in Julia
    push!(lessons, Lesson(
        "Map & Comprehensions",
        "Julia analogs of lapply/sapply: map, broadcasting, and comprehensions.",
        [
            mc("Which is most like R’s lapply?", ["map", "reduce", "sum", "filter"], 1),
            Question("Use map(length, [\"a\",\"abc\",\"ab\"]).", :code, [1, 3, 2], "Type exactly"),
            Question("[x^2 for x in 1:5 if x%2==1].", :code, [1, 9, 25], "Type the comprehension"),
            Question("Great!", :message, nothing)
        ]
    ))

    # 11. Group operations (DataFrames analog of tapply)
    push!(lessons, Lesson(
        "Group Operations",
        "Group-by style summaries using DataFrames (if installed).",
        [
            Question(
                "using DataFrames; df = DataFrame(g=[\"A\",\"A\",\"B\"], x=[1,2,3]); " *
                "combine(groupby(df, :g), :x => sum)",
                :code,
                nothing,
                "Type exactly; result is a DataFrame."
            ),
            Question("End.", :message, nothing)
        ]
    ))

    # 12. Looking at Data
    push!(lessons, Lesson(
        "Looking at Data",
        "Quick peeks at vectors and tables.",
        [
            Question("Take the first 3 of 10: first(collect(1:10), 3).", :code, [1, 2, 3],
                "Type: first(collect(1:10), 3)"),
            mc("Which shows summary stats for an array of numbers?",
                ["describe", "summary", "extrema", "var"], 2,
                "summary(x) works for many types; extrema gives (min,max)."),
            Question("extrema(3:7).", :code, (3, 7), "Type: extrema(3:7)"),
            Question("Done.", :message, nothing)
        ]
    ))

    # 13. Dates & Times
    push!(lessons, Lesson(
        "Dates and Times",
        "Use Dates stdlib for date/time work (lubridate analog).",
        [
            Question("using Dates; Date(\"2024-06-02\").year.", :code, 2024,
                "Type exactly"),
            Question("Parse DateTime(\"2025-11-04T09:30\").minute.", :code, 30,
                "Type exactly"),
            Question("Now() - DateTime(\"2025-01-01\") |> x->Dates.value(x) >= 0 ?", :code, true,
                "Construct any true boolean using Dates."),
            Question("Great!", :message, nothing)
        ]
    ))

    return Course(
        "Julia Programming (swirl port)",
        "A Julia reimagining of swirl’s classic R Programming basics: blocks, files, sequences, vectors, missing values, subsetting, matrices & DataFrames, logic, functions, map/comprehensions, group ops, data inspection, and dates.",
        lessons
    )
end
