local default_programs = {}

default_programs.terminal   = "kitty"
default_programs.editor     = os.getenv("EDITOR") or "nvim"
default_programs.ide        = "nvim"
default_programs.editor_cmd = default_programs.terminal .. " -e " .. default_programs.editor
default_programs.browser    = "firefox"

return default_programs
