
#!/bin/bash

# ==========================================
# CompTIA Security+ SY0-701 Practice Quiz
# ==========================================

SCORE=0
TOTAL=0

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

    ask_choice "$question" "$@"

    TOTAL=$((TOTAL + 1))

    if [[ "$CHOICE" == "$correct" ]]; then
        echo ""
        echo "[CORRECT]"
        SCORE=$((SCORE + 1))
    else
        echo ""
        echo "[INCORRECT]"
        echo "Correct answer: $correct"
    fi

    echo "Explanation: $explanation"
    echo ""
    echo "------------------------------------------"
}

# ==========================================
# QUIZ START
# ==========================================

echo "=========================================="
echo "    CompTIA Security+ SY0-701 Practice"
echo "=========================================="

ask_text "Enter your name"
NAME="$TEXT_ANSWER"

echo ""
echo "Welcome, $NAME!"
echo "Let's test your Security+ knowledge."

# QUESTION 1
ask_question \
"What security principle ensures users only have the permissions they need?" \
"2" \
"Least privilege limits access to only what is necessary to perform a job." \
"Defense in depth" \
"Least privilege" \
"Separation of duties" \
"Zero trust"

# QUESTION 2
ask_question \
"Which protocol provides encrypted communication for websites?" \
"3" \
"HTTPS uses TLS to encrypt communications between clients and web servers." \
"HTTP" \
"FTP" \
"HTTPS" \
"Telnet"

# QUESTION 3
ask_question \
"Which attack attempts to overwhelm a service with excessive traffic?" \
"1" \
"A denial-of-service attack attempts to make a system or service unavailable." \
"DDoS" \
"Phishing" \
"SQL injection" \
"Privilege escalation"

# QUESTION 4
ask_question \
"What is the primary purpose of hashing?" \
"2" \
"Hashing creates a fixed-length digest commonly used for integrity verification and secure password storage." \
"Encrypt data for transmission" \
"Verify data integrity" \
"Create digital certificates" \
"Hide network traffic"

# QUESTION 5
ask_question \
"Which authentication factor is something you ARE?" \
"4" \
"Biometrics such as fingerprints and facial recognition are something you are." \
"Password" \
"Security token" \
"PIN" \
"Fingerprint"

# QUESTION 6
ask_question \
"Which device is commonly used to filter network traffic based on security rules?" \
"1" \
"A firewall enforces traffic filtering rules between networks or systems." \
"Firewall" \
"Load balancer" \
"Hub" \
"DNS server"

# QUESTION 7
ask_question \
"What does the acronym MFA stand for?" \
"3" \
"Multi-factor authentication requires two or more different authentication factors." \
"Managed Firewall Access" \
"Multiple File Authorization" \
"Multi-Factor Authentication" \
"Mainframe Access"

# QUESTION 8
ask_question \
"Which vulnerability occurs when an application executes untrusted database input?" \
"2" \
"SQL injection occurs when attacker-controlled input is improperly incorporated into SQL queries." \
"Cross-site scripting" \
"SQL injection" \
"ARP spoofing" \
"DNS poisoning"

# QUESTION 9
ask_question \
"Which security concept assumes no user or device should be trusted automatically?" \
"4" \
"Zero Trust requires continuous verification of users, devices, and access requests." \
"Least privilege" \
"Defense in depth" \
"Implicit trust" \
"Zero Trust"

# QUESTION 10
ask_question \
"What is the primary purpose of a SIEM solution?" \
"1" \
"A SIEM collects and correlates security logs to support monitoring, detection, and incident investigation." \
"Collect and analyze security events" \
"Encrypt network traffic" \
"Manage user passwords" \
"Replace firewalls"

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
echo "Thank you for practicing Security+!"

