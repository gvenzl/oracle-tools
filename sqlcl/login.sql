-- MIT License
--
-- Copyright (c) 2026 Gerald Venzl
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

-- Use spaces instead of tab (copy/paste)
set tab off
-- Do not print line numbers (copy/paste)
set linenumbers off
-- Show status bar at the bottom
set statusbar on
-- Status bar: current workding directory
set statusbar add cwd
-- Status bar: git repo status
set statusbar add git
-- Status bar: Oracle DB transaction status
set statusbar add txn
-- Status bar: Timing of last SQL
set statusbar add timing
-- Turn on syntax highlighting
set highlighting on
-- Define highlghting colors
set highlighting keyword foreground green
set highlighting identifier foreground magenta
set highlighting string foreground yellow
set highlighting number foreground cyan
set highlighting comment background white
set highlighting comment foreground black
-- Set output to ansiconsole (clear text)
set sqlformat ansiconsole
set sqlprompt "SQL> "
-- Alternative SQL prompt prefix
--set sqlprompt "@|red _USER|@@@|green _CONNECT_IDENTIFIER > |@"
