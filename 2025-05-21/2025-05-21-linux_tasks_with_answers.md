# Practical Linux Tasks – Sample Answers

```bash
# 1. Create a working directory called `workspace`
mkdir workspace

# 2. Enter the `workspace` directory
cd workspace

# 3. Create two subdirectories: `notes` and `logs`
mkdir notes logs

# 4. Inside `notes`, create two text files: `todo.txt` and `ideas.txt`
touch notes/todo.txt notes/ideas.txt

# 5. Add three tasks to `todo.txt` (one per line)
echo -e "Finish report\nUpdate resume\nStart new project" > notes/todo.txt

# 6. Append a new idea to `ideas.txt`
echo "Develop a mobile app for students" >> notes/ideas.txt

# 7. Copy the `todo.txt` file into the `logs` directory as `todo_backup.txt`
cp notes/todo.txt logs/todo_backup.txt

# 8. Move the `ideas.txt` file to the main `workspace` folder
mv notes/ideas.txt .

# 9. Rename `ideas.txt` to `inspirations.txt`
mv ideas.txt inspirations.txt

# 10. Display the contents of `todo.txt` with line numbers
cat -n notes/todo.txt

# 11. Show only the first 2 lines of `todo.txt`
head -n 2 notes/todo.txt

# 12. Show the last line of `todo.txt`
tail -n 1 notes/todo.txt

# 13. Count how many tasks are listed in `todo.txt`
wc -l < notes/todo.txt

# 14. Search for the word "project" in `todo.txt`
grep "project" notes/todo.txt

# 15. Combine `todo.txt` and `inspirations.txt` into `summary.txt`
cat notes/todo.txt inspirations.txt > summary.txt

# 16. Overwrite `todo_backup.txt` with just the word "Done"
echo "Done" > logs/todo_backup.txt

# 17. Add a timestamp line to `logs/log.txt`
date >> logs/log.txt

# 18. Append the contents of `todo.txt` to `log.txt`
cat notes/todo.txt >> logs/log.txt

# 19. Display `log.txt` using `less`
less logs/log.txt

# 20. Count how many times "Learn" appears in `log.txt`
grep -o "Learn" logs/log.txt | wc -l

# 21. Display the file permissions for everything in the current directory
ls -l

# 22. Show your current username and home directory
echo "User: $USER"
echo "Home: $HOME"

# 23. List all currently logged-in users
who

# 24. Display current date and time
date

# 25. Show how long the system has been running
uptime

# 26. Show memory usage in human-readable format
free -h

# 27. Display your system kernel and architecture info
uname -a

# 28. List all running processes
ps aux

# 29. Use `top` to monitor system processes
top
```
