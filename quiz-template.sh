
#!/bin/bash

# ==========================================
# CompTIA Security+ SY0-701 Practice Quiz
# ==========================================

SCORE=0
TOTAL=0
CORRECT_QUESTIONS=()
INCORRECT_QUESTIONS=()

# Multiple-choice function
ask_choice() {
    local question="$1"
    shift
    local options=("$@")
    local answer

    echo ""
    echo "$question"

    for i in "${!options[@]}"; do
        echo "  $((i + 1))) ${options[$i]}"
    done

    while true; do
        read -rp "Your answer (1-${#options[@]}): " answer

        if [[ "$answer" =~ ^[0-9]+$ ]] &&
           (( answer >= 1 && answer <= ${#options[@]} )); then
            CHOICE="$answer"
            return
        else
            echo "Invalid selection. Try again."
        fi
    done
}

# Free-text function
ask_text() {
    local question="$1"
    read -rp "$question: " TEXT_ANSWER
}

# Quiz question function
ask_question() {
    local question="$1"
    local correct="$2"
    local explanation="$3"
    shift 3

    local options=("$@")
    local user_answer
    local selected_answer

    ask_choice "$question" "${options[@]}"

    user_answer="$CHOICE"
    selected_answer="${options[$((user_answer - 1))]}"

    TOTAL=$((TOTAL + 1))

    if [[ "$user_answer" == "$correct" ]]; then
        echo ""
        echo "[CORRECT]"
        SCORE=$((SCORE + 1))

        CORRECT_QUESTIONS+=("$question")
    else
        echo ""
        echo "[INCORRECT]"

        INCORRECT_QUESTIONS+=(
            "$question|Your answer: $selected_answer|Correct answer: ${options[$((correct - 1))]}"
        )
    fi

    echo "Explanation: $explanation"
    echo "------------------------------------------"
}

# ==========================================
# QUIZ START
# ==========================================

echo "=========================================="
echo "    	   Quiz name"
echo "=========================================="

ask_text "Enter your name"
NAME="$TEXT_ANSWER"

echo ""
echo "Welcome, $NAME!"
echo "Let's test your Security+ knowledge."

# QUESTIONS
ask_question \
"question" \
"correct answer 1-4" \
"reason for correct answer" \
"answer 1" \
"answer 2" \
"answer 3" \
"answer 4"

# ==========================================

echo ""
echo "=========================================="
echo "             QUESTION REVIEW"
echo "=========================================="

# Correct Answers
echo ""
echo "========== CORRECT ANSWERS =============="

if (( ${#CORRECT_QUESTIONS[@]} == 0 )); then
    echo "No correctly answered questions."
else
    for i in "${!CORRECT_QUESTIONS[@]}"; do
        echo "$((i + 1)). ${CORRECT_QUESTIONS[$i]}"
    done
fi

# Incorrect Answers
echo ""
echo "========== INCORRECT ANSWERS ============"

if (( ${#INCORRECT_QUESTIONS[@]} == 0 )); then
    echo "No incorrectly answered questions."
else
    for i in "${!INCORRECT_QUESTIONS[@]}"; do
        echo "$((i + 1)). ${INCORRECT_QUESTIONS[$i]}"
    done
fi

echo ""
echo "=========================================="

# ==========================================
# FINAL RESULTS
# ==========================================

PERCENTAGE=$((SCORE * 100 / TOTAL))

echo ""
echo "=========================================="
echo "             QUIZ RESULTS"
echo "=========================================="
echo "Student: $NAME"
echo "Questions: $TOTAL"
echo "Correct: $SCORE"
echo "Incorrect: $((TOTAL - SCORE))"
echo "Final Score: $PERCENTAGE%"
echo "=========================================="

if (( PERCENTAGE >= 90 )); then
    echo "Excellent! Strong Security+ knowledge."
elif (( PERCENTAGE >= 80 )); then
    echo "Good job! Keep studying."
elif (( PERCENTAGE >= 70 )); then
    echo "Decent progress. Review missed concepts."
else
    echo "More studying recommended. Keep practicing!"
fi

echo ""
