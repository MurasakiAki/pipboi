import curses
import sys
import keyboard

def main(stdscr, filename):
    curses.curs_set(1)  # Set cursor to 1 to make it visible
    stdscr.clear()

    # Set up colors
    curses.start_color()
    curses.init_pair(1, curses.COLOR_CYAN, curses.COLOR_BLACK)

    # Load file content
    try:
        with open(filename, 'r') as file:
            text = file.read().splitlines()
    except FileNotFoundError:
        text = [""]

    # Set initial variables
    y, x = 0, 0
    height, width = stdscr.getmaxyx()

    def save_file():
        with open(filename, "w") as file:
            file.write('\n'.join(text))

    while True:
        stdscr.clear()

        # Display text
        for i, line in enumerate(text):
            stdscr.addstr(i, 0, line[:width-1])

        # Display cursor
        try:
            stdscr.addstr(y, x, '█', curses.color_pair(1))
        except curses.error:
            pass  # Ignore if cursor is outside the screen

        # Refresh the screen
        stdscr.refresh()

        # Get user input
        try:
            key = keyboard.read_event(suppress=True).name

            if key == 'up' and y > 0:
                y -= 1
            elif key == 'down' and y < len(text) - 1:
                y += 1
            elif key == 'left' and x > 0:
                x -= 1
            elif key == 'right' and x < len(text[y]) - 1:
                x += 1
            elif key == 'enter':
                # Move to a new line
                if y == len(text) - 1:
                    text.append("")
                else:
                    text.insert(y + 1, text[y][x:])
                    text[y] = text[y][:x]
                y += 1
                x = 0
            elif key == 'backspace':
                # Delete character
                if x > 0:
                    text[y] = text[y][:x - 1] + text[y][x:]
                    x -= 1
                elif y > 0:
                    # Join the current line with the line above
                    x = len(text[y - 1])
                    text[y - 1] += text[y]
                    del text[y]
                    y -= 1
            elif key == 'ctrl+q':
                # Save and exit on Ctrl+Q
                save_file()
                break
            elif key == 'esc':
                # Quit without saving
                break
            elif len(key) == 1:
                # Insert printable character
                text[y] = text[y][:x] + key + text[y][x:]
                x += 1

        except KeyboardInterrupt:
            # Handle Ctrl+C without crashing
            break

    save_file()

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python pico.py <filename>")
        sys.exit(1)

    curses.wrapper(main, sys.argv[1])
