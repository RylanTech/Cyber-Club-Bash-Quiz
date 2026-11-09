
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
echo "           SEC+ & Linux Quiz"
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
# LINUX SECURITY+ QUESTIONS (11-20)
# ==========================================

# QUESTION 11
ask_question \
"Which Linux command displays file permissions and ownership?" \
"2" \
"The ls -l command displays file permissions, ownership, file size, and modification date." \
"chmod" \
"ls -l" \
"chown" \
"pwd"

# QUESTION 12
ask_question \
"Which Linux command changes file permissions?" \
"1" \
"The chmod command modifies read, write, and execute permissions on files and directories." \
"chmod" \
"chown" \
"umask" \
"sudo"

# QUESTION 13
ask_question \
"Which Linux file stores local user account information?" \
"3" \
"/etc/passwd contains user account information, including usernames and user IDs. Password hashes are typically stored in /etc/shadow." \
"/etc/shadow" \
"/etc/group" \
"/etc/passwd" \
"/var/log/auth.log"

# QUESTION 14
ask_question \
"Which command displays authentication-related logs on many Linux distributions?" \
"4" \
"/var/log/auth.log is commonly used on Debian-based systems. RHEL-based systems commonly use /var/log/secure. systemd systems may also use journalctl." \
"ls /etc" \
"cat /etc/passwd" \
"ps aux" \
"cat /var/log/auth.log"

# QUESTION 15
ask_question \
"Which Linux command allows a user to execute commands with elevated privileges?" \
"2" \
"sudo allows authorized users to execute commands with elevated privileges according to sudoers policy." \
"su -" \
"sudo" \
"chmod" \
"whoami"

# QUESTION 16
ask_question \
"What does permission 755 mean in Linux?" \
"1" \
"755 means the owner has read, write, and execute permissions (7), while the group and others have read and execute permissions (5)." \
"Owner: rwx, Group: r-x, Others: r-x" \
"Owner: rw-, Group: rw-, Others: r--" \
"Owner: r--, Group: r--, Others: r--" \
"Owner: rwx, Group: rwx, Others: rwx"

# QUESTION 17
ask_question \
"Which Linux command displays currently running processes?" \
"3" \
"The ps aux command displays a detailed snapshot of running processes." \
"chmod" \
"netstat" \
"ps aux" \
"mkdir"

# QUESTION 18
ask_question \
"Which Linux command can identify listening network ports?" \
"4" \
"ss -tulnp displays listening TCP and UDP sockets and associated processes when permissions allow." \
"ls -la" \
"df -h" \
"chmod -R" \
"ss -tulnp"

# QUESTION 19
ask_question \
"Which command is commonly used to search for suspicious text in Linux log files?" \
"2" \
"grep searches files for matching text patterns and is useful for identifying suspicious log entries." \
"chmod" \
"grep" \
"chown" \
"mount"

# QUESTION 20
ask_question \
"Which Linux command displays recent system journal entries and authentication events?" \
"1" \
"journalctl retrieves logs collected by systemd-journald. The -u option can filter logs by service." \
"journalctl" \
"chmod" \
"passwd" \
"hostname"

# QUESTION 21
ask_question \
"What is a linux?" \
"3" \
"Linux is a kernal, which is the layer between hardware and software" \
"An operating system" \
"A collection of software used on a computer" \
"A kernel" \
"A version of Windows"


# ==========================================
# QUESTION REVIEW
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
