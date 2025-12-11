local default_programs = {}

default_programs.terminal = "kitty"
default_programs.editor = os.getenv("EDITOR") or "code"
default_programs.ide = "code"
default_programs.editor_cmd = default_programs.terminal .. " -e " .. default_programs.editor
default_programs.browser = "zen-browser"
default_programs.pdf_viewer = "zathura"

return default_programs
